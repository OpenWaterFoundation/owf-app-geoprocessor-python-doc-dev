#!/bin/sh
#
# Copy the site/* contents to the software.openwaterfoundation.org website
# - replace all the files on the web with local files
# - must specify Amazon profile as argument to the script

# Supporting functions, alphabetized.

# Make sure the MkDocs version is consistent with the documentation content:
# - require that at least version 1.0 is used because of use_directory_urls = True default
# - must use "file.md" in internal links whereas previously "file" would work
# - it is not totally clear whether version 1 is needed but try this out to see if it helps avoid broken links
checkMkdocsVersion() {
  # Required MkDocs version is at least 1.
  requiredMajorVersion="1"
  # On Cygwin, mkdocs --version gives:  mkdocs, version 1.0.4 from /usr/lib/python3.6/site-packages/mkdocs (Python 3.6)
  # On Debian Linux, similar to Cygwin:  mkdocs, version 0.17.3
  # On newer windows: MkDocs --version:  python -m mkdocs, version 1.3.1 from C:\Users\steve\AppData\Local\Programs\Python\Python310\lib\site-packages\mkdocs (Python 3.10)
  # The following should work for any version after a comma.
  mkdocsVersionFull=$(${mkdocsExe} --version | sed -e 's/.*, \(version .*\)/\1/g' | cut -d ' ' -f 2)
  echo "MkDocs --version:  ${mkdocsVersionFull}"
  mkdocsVersion=$(echo ${mkdocsVersionFull} | cut -d ' ' -f 3)
  if [ -z "${mkdocsVersion}" ]; then
    echo "Error getting MkDocs version.  Is it installed?"
    exit 1
  fi
  echo "MkDocs full version number:  ${mkdocsVersion}"
  mkdocsMajorVersion=$(echo ${mkdocsVersion} | cut -d '.' -f 1)
  echo "MkDocs major version number:  ${mkdocsMajorVersion}"
  if [ "${mkdocsMajorVersion}" -lt ${requiredMajorVersion} ]; then
    echo ""
    echo "MkDocs version for this documentation must be version ${requiredMajorVersion} or later."
    echo "MkDocs version that is found is ${mkdocsMajorVersion}, from full version ${mkdocsVersion}."
    exit 1
  else
    echo ""
    echo "MkDocs major version (${mkdocsMajorVersion}) is OK for this documentation."
  fi
}

# Determine the operating system that is running the script:
# - mainly care whether Cygwin or MINGW
checkOperatingSystem() {
  if [ ! -z "${operatingSystem}" ]; then
    # Have already checked operating system so return.
    return
  fi
  operatingSystem="unknown"
  os=`uname | tr [a-z] [A-Z]`
  case "${os}" in
    CYGWIN*)
      operatingSystem="cygwin"
      ;;
    LINUX*)
      operatingSystem="linux"
      ;;
    MINGW*)
      operatingSystem="mingw"
      ;;
  esac
}

# Check the source files for issues
# - the main issue is internal links need to use [](file.md), not [](file)
checkSourceDocs() {
  # Currently don't do anything but could check the above
  # Need one line to not cause an error
  :
}

# Get the CloudFront distribution ID from the bucket so the ID is not hard-coded.
# The distribution ID is echoed and can be assigned to a variable.
# The output is similar to the following (obfuscated here):
# ITEMS   arn:aws:cloudfront::123456789000:distribution/ABCDEFGHIJKLMN    learn.openwaterfoundation.org   123456789abcde.cloudfront.net   True    HTTP2   ABCDEFGHIJKLMN  True    2022-01-05T23:29:28.127000+00:00        PriceClass_100  Deployed
getCloudFrontDistribution() {
  local cloudFrontDistributionId subdomain
  subdomain="software.openwaterfoundation.org"
  cloudFrontDistributionId=$(${awsExe} cloudfront list-distributions --output text --profile "${awsProfile}" | grep ${subdomain} | grep "arn:" | awk '{print $2}' | cut -d ':' -f 6 | cut -d '/' -f 2)
  echo ${cloudFrontDistributionId}
}

# Get the version of the GeoProcessor software
# - get from the source file
getVersion() {
  #local gitRepoFolder, gpRepoFolder, repoFolder, srcFolder
  #local majorVersion, microVersion, minorVersion, modVersion

  # repoFolder should be '/.../owf-app-geoprocessor-doc-dev'
  repoFolder=$(dirname ${scriptFolder})
  # gitReposFolder should be '/.../git-repos'
  gitReposFolder=$(dirname ${repoFolder})
  # gpRepoFolder should be '/.../owf-app-geoprocessor-python'
  gpRepoFolder="${gitReposFolder}/owf-app-geoprocessor-python"
  srcFolder="${gpRepoFolder}/geoprocessor/app"
  versionFile="${srcFolder}/version.py"
  if [ -f "${versionFile}" ]; then
    echo "Getting version from:  ${versionFile}"
  else
    echo "Version folder does not exist:  ${versionFile}"
    exit 1
  fi
  # Get the version parts because full version string is not a literal in code
  majorVersion=$(grep app_version_major ${versionFile} | grep -v '{}' | cut -d '=' -f 2 | tr -d " " | tr -d '"')
  minorVersion=$(grep app_version_minor ${versionFile} | grep -v '{}' | cut -d '=' -f 2 | tr -d " " | tr -d '"')
  microVersion=$(grep app_version_micro ${versionFile} | grep -v '{}' | cut -d '=' -f 2 | tr -d " " | tr -d '"')
  modVersion=$(grep app_version_mod ${versionFile} | grep -v '{}' | cut -d '=' -f 2 | tr -d " " | tr -d '"')
  # Form the version from the parts, will be globally visible
  version="${majorVersion}.${minorVersion}.${microVersion}.${modVersion}"
  echo "Determined version=${version}"
}

# Invalidate a CloudFront distribution for files:
# - first parameter is the CloudFront distribution ID
# - second parameter is the CloudFront folder.
# - ${awsProfile} must be set in global data
invalidateCloudFront() {
  local errorCode cloudFrontDistributionId cloudFrontFolder
  if [ -z "$1" ]; then
    logError "CloudFront distribution ID is not specified.  Script error."
    return 1
  fi
  if [ -z "$2" ]; then
    logError "CloudFront folder is not specified.  Script error."
    return 1
  fi
  # Check global data.
  if [ -z "${awsProfile}" ]; then
    logError "'awsProfile' is not set.  Script error."
    exit 1
  fi
  cloudFrontDistributionId=$1
  cloudFrontFolder=$2

  # Invalidate for CloudFront so that new version will be displayed:
  # - see:  https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Invalidation.html
  # - TODO smalers 2020-04-13 for some reason invalidating /index.html does not work, have to do "/index.html*"
  echo "Invalidating files so CloudFront will make new version available..."
  ${awsExe} cloudfront create-invalidation --distribution-id "${cloudFrontDistributionId}" --paths "${cloudFrontFolder}" --output json --profile "${awsProfile}"
  errorCode=$?

  return ${errorCode}
}

# Set the AWS executable:
# - handle different operating systems
# - for AWS CLI V2, can call an executable
# - for AWS CLI V1, have to deal with Python
# - once set, use ${awsExe} as the command to run, followed by necessary command parameters
setAwsExe() {
  if [ "${operatingSystem}" = "mingw" ]; then
    # "mingw" is Git Bash:
    # - the following should work for V2
    # - if "aws" is in path, use it
    awsExe=$(command -v aws)
    if [ -n "${awsExe}" ]; then
      # Found aws in the PATH.
      awsExe="aws"
    else
      # Might be older V1.
      # Figure out the Python installation path.
      pythonExePath=$(py -c "import sys; print(sys.executable)")
      if [ -n "${pythonExePath}" ]; then
        # Path will be something like:  C:\Users\sam\AppData\Local\Programs\Python\Python37\python.exe
        # - so strip off the exe and substitute Scripts
        # - convert the path to posix first
        pythonExePathPosix="/$(echo "${pythonExePath}" | sed 's/\\/\//g' | sed 's/://')"
        pythonScriptsFolder="$(dirname "${pythonExePathPosix}")/Scripts"
        echo "${pythonScriptsFolder}"
        awsExe="${pythonScriptsFolder}/aws"
      else
        echo "[ERROR] Unable to find Python installation location to find 'aws' script"
        echo "[ERROR] Make sure Python 3.x is installed on Windows so 'py' is available in PATH"
        exit 1
      fi
    fi
  else
    # For other Linux, including Cygwin, just try to run.
    awsExe="aws"
  fi
}

# Set the MkDocs executable to use, depending operating system and PATH:
# - sets the global ${mkdocsExe} variable
# - return 0 if the executable is found, exit with 1 if not
setMkDocsExe() {
  if [ "${operatingSystem}" = "linux" ]; then
    # Is usually in the PATH.
    mkdocsExe="mkdocs"
    if hash py 2>/dev/null; then
      echo "mkdocs is not found (not in PATH)."
      exit 1
    fi
  elif [ "${operatingSystem}" = "cygwin" ]; then
    if hash py 2>/dev/null; then
      mkdocsExe="py -m mkdocs"
    else
      # Try adding the Windows folder to the PATH and rerun:
      # - not sure why C:\Windows is not in the path in the first place
      PATH=/cygdrive/C/Windows:${PATH}
      if hash py 2>/dev/null; then
        mkdocsExe="py -m mkdocs"
      else
        echo 'mkdocs is not found in C:\Windows.'
        exit 1
      fi
    fi
  elif [ "${operatingSystem}" = "mingw" ]; then
    # This is used by Git Bash:
    # - calling 'hash' is a way to determine if the executable is in the path
    if hash py 2>/dev/null; then
      mkdocsExe="py -m mkdocs"
    else
      # Try adding the Windows folder to the PATH and rerun:
      # - not sure why C:\Windows is not in the path in the first place
      PATH=/C/Windows:${PATH}
      if hash py 2>/dev/null; then
        mkdocsExe="py -m mkdocs"
      else
        echo 'mkdocs is not found in C:\Windows.'
        exit 1
      fi
    fi
  fi
  return 0
}

# Entry point into the script.

# Check the operating system.
checkOperatingSystem

# Set the MkDocs executable:
# - will exit if MkDocs is not found
setMkDocsExe

# Set the AWS CLI executable.
setAwsExe

# Make sure the MkDocs version is OK.
checkMkdocsVersion

# Check the source files for issues.
checkSourceDocs

# Get the folder where this script is located since it may have been run from any folder.
scriptFolder=$(cd $(dirname "$0") && pwd)
echo "Script folder = ${scriptFolder}"
# Change to the folder where the script is since other actions below are relative to that.
cd ${scriptFolder} || exit

# Get the software version:
# - needs to be here (before setting S3 folder an printing usage)
getVersion

# Set --dryrun to test before actually doing.
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
  echo "  ${s3VersionFolder}"
  echo "  ${s3LatestFolder}"
  echo ""
  exit 0
fi

awsProfile="$1"

# First build the site so that the "site" folder contains current content:
# - "mkdocs serve" does not do this

echo "Building mkdocs-project/site folder..."
cd ../mkdocs-project || exit

${mkdocsExe} build --clean

cd ${scriptFolder} || exit

# Now sync the local files up to Amazon S3.
s3ExitStatusVersion=0
cloudFrontExitStatusVersion=0
if [ -n "${version}" ]; then
  # Upload documentation to the versioned folder.
  echo "Uploading documentation to:  ${s3VersionFolder}"
  read -p "Continue [Y/n/q]? " answer
  if [ -z "${answer}" -o "${answer}" = "y" -o "${answer}" = "Y" ]; then 
    ${awsExe} s3 sync ../mkdocs-project/site ${s3VersionFolder} ${dryrun} --delete --profile "${awsProfile}"
    s3ExitStatusVersion=$?

    # Invalidate the CloudFront distribution for the versioned folder.
    cloudFrontDistributionId=$(getCloudFrontDistribution)
    if [ -z "${cloudFrontDistributionId}" ]; then
      echo "Error getting the CloudFront distribution."
      exit 1
    fi
    cloudFrontFolder="/software/geoprocessor/${version}/doc-user/*"
    invalidateCloudFront ${cloudFrontDistributionId} ${cloudFrontFolder}
    cloudFrontExitStatusVersion=$?

  elif [ "${answer}" = "q" ]; then 
    exit 0
  fi
fi

read -p "Also copy documentation to 'latest' [y/n/q]? " answer
s3ExitStatusLatest=0
cloudFrontExitStatusLatest=0
if [ "${answer}" = "y" ]; then 
  echo "Uploading documentation to:  ${s3LatestFolder}"
  read -p "Continue [Y/n/q]? " answer
  if [ -z "${answer}" -o "${answer}" = "y" -o "${answer}" = "Y" ]; then 
    ${awsExe} s3 sync ../mkdocs-project/site ${s3LatestFolder} ${dryrun} --delete --profile "${awsProfile}"
    s3ExitStatusLatest=$?

    # Invalidate the CloudFront distribution for the latest folder.
    cloudFrontDistributionId=$(getCloudFrontDistribution)
    if [ -z "${cloudFrontDistributionId}" ]; then
      echo "Error getting the CloudFront distribution."
      exit 1
    fi
    cloudFrontFolder="/software/geoprocessor/latest/doc-user/*"
    invalidateCloudFront ${cloudFrontDistributionId} ${cloudFrontFolder}
    cloudFrontExitStatusLatest=$?
  elif [ "${answer}" = "q" ]; then 
    exit 0
  fi
fi

exitStatus=$(( ${s3ExitStatusVersion} + + ${cloudFrontExitStatusVersion} + ${s3ExitStatusLatest} + ${cloudFrontExitStatusLatest} ))
exit ${exitStatus}
