#!/bin/sh
#
# Copy the site/* contents to the software.openwaterfoundation.org website
# - replace all the files on the web with local files
# - must specify Amazon profile as argument to the script

# Supporting functions, alphabetized

# Make sure the MkDocs version is consistent with the documentation content
# - require that at least version 1.0 is used because of use_directory_urls = True default
# - must use "file.md" in internal links whereas previously "file" would work
# - it is not totally clear whether version 1 is needed but try this out to see if it helps avoid broken links
checkMkdocsVersion() {
	# Required MkDocs version is at least 1
	requiredMajorVersion="1"
	# On Cygwin, mkdocs --version gives:  mkdocs, version 1.0.4 from /usr/lib/python3.6/site-packages/mkdocs (Python 3.6)
	mkdocsVersionFull=$(mkdocs --version)
	echo "MkDocs --version:  $mkdocsVersionFull"
	mkdocsVersion=$(echo $mkdocsVersionFull | cut -d ' ' -f 3)
	echo "MkDocs full version number:  $mkdocsVersion"
	mkdocsMajorVersion=$(echo $mkdocsVersion | cut -d '.' -f 1)
	echo "MkDocs major version number:  $mkdocsMajorVersion"
	if [ "$mkdocsMajorVersion" -lt $requiredMajorVersion ]; then
		echo ""
		echo "MkDocs version for this documentation must be version $requiredMajorVersion or later."
		echo "MkDocs mersion that is found is $mkdocsMajorVersion, from full version ${mkdocsVersion}."
		exit 1
	else
		echo ""
		echo "MkDocs major version ($mkdocsMajorVersion) is OK for this documentation."
	fi
}

# Check the source files for issues
# - the main issue is internal links need to use [](file.md), not [](file)
checkSourceDocs() {
	# Currently don't do anything but could check the above
	# Need one line to not cause an error
	:
}

# Get the version of the GeoProcessor software
# - get from the source file
getVersion() {
	#local gitRepoFolder, gpRepoFolder, repoFolder, srcFolder
	#local majorVersion, microVersion, minorVersion, modVersion

	# repoFolder should be '/.../owf-app-geoprocessor-doc-dev'
	repoFolder=$(dirname $scriptFolder)
	# gitReposFolder should be '/.../git-repos'
	gitReposFolder=$(dirname $repoFolder)
	# gpRepoFolder should be '/.../owf-app-geoprocessor-python'
	gpRepoFolder="${gitReposFolder}/owf-app-geoprocessor-python"
	srcFolder="${gpRepoFolder}/geoprocessor/app"
	versionFile="${srcFolder}/version.py"
	if [ -f "${versionFile}" ]; then
		echo "Getting version from:  $versionFile"
	else
		echo "Version folder does not exist:  $versionFile"
		exit 1
	fi
	# Get the version parts because full version string is not a literal in code
	majorVersion=$(grep app_version_major $versionFile | grep -v str | cut -d '=' -f 2 | tr -d " " | tr -d '"')
	minorVersion=$(grep app_version_minor $versionFile | grep -v str | cut -d '=' -f 2 | tr -d " " | tr -d '"')
	microVersion=$(grep app_version_micro $versionFile | grep -v str | cut -d '=' -f 2 | tr -d " " | tr -d '"')
	modVersion=$(grep app_version_mod $versionFile | grep -v str | cut -d '=' -f 2 | tr -d " " | tr -d '"')
	# Form the version from the parts, will be globally visible
	version="${majorVersion}.${minorVersion}.${microVersion}.${modVersion}"
	echo "Determined version=${version}"
}

# Entry point into the script

# Make sure the MkDocs version is OK
checkMkdocsVersion

# Check the source files for issues
checkSourceDocs

# Get the folder where this script is located since it may have been run from any folder
scriptFolder=$(cd $(dirname "$0") && pwd)
echo "Script folder = ${scriptFolder}"
# Change to the folder where the script is since other actions below are relative to that
cd ${scriptFolder}

# Get the software version
getVersion

# Set --dryrun to test before actually doing
dryrun=""
#dryrun="--dryrun"
s3VersionFolder="s3://software.openwaterfoundation.org/geoprocessor/${version}/doc-dev"
s3LatestFolder="s3://software.openwaterfoundation.org/geoprocessor/latest/doc-dev"

if [ "$1" == "" ]
	then
	echo ""
	echo "Usage:  $0 AmazonConfigProfile"
	echo ""
	echo "Copy the site files to the Amazon S3 static website folders:"
	echo "  $s3VersionFolder"
	echo "  $s3LatestFolder"
	echo ""
	exit 0
fi

awsProfile="$1"

# First build the site so that the "site" folder contains current content.
# - "mkdocs serve" does not do this

echo "Building mkdocs-project/site folder..."
cd ../mkdocs-project
mkdocs build --clean
cd ${scriptFolder}

# Now sync the local files up to Amazon S3
if [ -n "${version}" ]; then
	# Upload documentation to the versioned folder
	echo "Uploading documentation to:  ${s3VersionFolder}"
	read -p "Continue [Y/n/q]? " answer
	if [ -z "${answer}" -o "${answer}" = "y" -o "${answer}" = "Y" ]; then 
		aws s3 sync ../mkdocs-project/site ${s3VersionFolder} ${dryrun} --delete --profile "$awsProfile"
		exitStatusVersion=$?
	elif [ "${answer}" = "q" ]; then 
		exit 0
	fi
fi

read -p "Also copy documentation to 'latest' [y/n]? " answer
exitStatusLatest=0
if [ "${answer}" = "y" ]; then 
	echo "Uploading documentation to:  ${s3LatestFolder}"
	read -p "Continue [Y/n/q]? " answer
	if [ -z "${answer}" -o "${answer}" = "y" -o "${answer}" = "Y" ]; then 
		aws s3 sync ../mkdocs-project/site ${s3LatestFolder} ${dryrun} --delete --profile "$awsProfile"
		exitStatusLatest=$?
	elif [ "${answer}" = "q" ]; then 
		exit 0
	fi
fi

exitStatus=$(expr ${exitStatusVersion} + ${exitStatusLatest})
exit ${exitStatus}
