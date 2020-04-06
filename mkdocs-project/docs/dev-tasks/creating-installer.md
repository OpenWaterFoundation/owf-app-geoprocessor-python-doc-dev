# GeoProcessor / Development Tasks / Creating Installer #

The GeoProcessor is not packaged via a `pip` or `pipenv` installer (or `apt-get` on Linux).
The current focus is Windows and a zip file is used to deploy a virtual environment.
The deployment process uses a Python virtual environment.

The GeoProcessor software can then be installed as per the
[User Documentation](http://software.openwaterfoundation.org/geoprocessor/latest/doc-user/appendix-install/install/).

Installers are created for different operating systems:

* [Introduction](#introduction)
* [Create Installer](#create-installer)
	+ ![cygwin](../images/cygwin-32.png) [Creating Installer for Cygwin](#creating-installer-for-cygwin)
	+ ![linux](../images/linux-32.png) [Creating Installer for Linux](#creating-installer-for-linux)
	+ ![windows](../images/windows-32.png) [Creating Installer for Windows](#creating-installer-for-windows)

---------------

## Introduction ##

The goal for GeoProcessor installer is to use an approach that is
consistent with norms and best practices for the target operating system.
Current development focuses on Windows, with deployment as a zip file containing a Python virtual environment.
Similarly, distribution on Linux is by gzipped tar file.
More advanced installers for each platform will be developed over time.

A goal is also to be able to install the GeoProcessor software without requiring that the
user install any other software (other than QGIS or ArcGIS Pro).
This is different than Python approaches that rely on users
installing packages into the virtual environment.

The following table summarizes the files that are assembled to create the installer.

**<p style="text-align: center;">
Components for GeoProcessor Installer
</p>**

| **Component / Files**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | **Description** |
| -- | -- |
| Python virtual environment | Use QGIS Python to run `virtualenv` and create a virtual environment. |
| `geoprocessor` Python module files | Copied from `geoprocessor` folder in the repository. |
| GeoProcessor run scripts | Copied from the `scripts` folder in the repository. |
| `GeoProcessor-QGIS-Version.txt` | Created during packaging to indicate QGIS version for installer. |
| `Lib/site-packages` | Additional python packages needed by GeoProcessor are installed into the virtual environment using the virtual environment Python's `pip`. |
| `License.md` | Copied from repository main folder. |

The general process to create the installer is as follows:

1. The command line script to create the installer is run, based on operating system (see sections below).
2. The temporary folder `build/venv-tmp/` is created, if it does not exist, to hold virtual environments that are created.
3. A folder is created in the above folder with name like `gp-1.3.0-win-qgis-3.10-venv/`,
which holds the virtual environment while component files are copied into the virtual environment.
The folder name indicates the GeoProcessor version, target operating system, and QGIS version.
The Python version can be determined at runtime based on the QGIS version and files.
4. The temporary virtual environment is packaged into a self-extracting installer,
currently just a zip file.
5. The installer is uploaded to the cloud, so that it can be downloaded.

The following section describes how to create the installer for each target operating system.

## Create Installer ##

The following sections describe how to create GeoProcessor installer for each supported operating system.
Currently Windows is the focus.

### ![Cygwin](../images/cygwin-32.png) Creating Installer for Cygwin ###

**This documentation needs to be updated.  Changes to the development environment have occurred since the last public release.**

The Cygwin installer currently focuses on the testing framework.
A Cygwin deployment is useful for testing the GeoProcessor testing framework prior to testing the Linux installer.

The Cygwin environment must have been properly configured as per the [Development Environment / Cygwin](../dev-env/cygwin.md) documentation.
A Python virtual environment is created in the development environment.
The following steps are executed:

1. Run `build-util/1-create-gp-tar.sh` to create `tar.gz` and `.zip` files that contain the `site-packages` files.
	1. This creates temporary folders in `build-util/build-tmp` containing the Python files, for example:
		1. `build-util/build-tmp/tmp-gp-1.1.0` contains the needed GeoProcessor files
		2. `build-util/build-tmp/gp-1.1.0-site-package.tar.gz contains the site `geoview` package for the GeoProcessor
		3. similarly, `gptest` files are created
	2. The testing framework version (`gptest`) has QGIS references stripped from the code.
2. Run `build-util/2-create-gp-venv.sh` to create a Python virtual environment.
	1. This creates a virtual environment from the files in the previous step, for example:
		1. `build-util/venv-tmp/gptest-1.1.0-cyg-venv` contains the virtual environment for
		testing framework version 1.1.0 for Cygwin
		2. `build-util/venv-tmp/gptest-1.1.0-cyg-venv.tar.gz` is the installer that can be deployed to a Cygwin environment
	2. Necessary components are also installed using `pip`.
3. More frequently, when code or other source files are edited and need to be tested in Cygwin, run `build-util/2-update-gp-venv.sh` to
	run step 1 and parts of step 2 that copy source code and scripts to the virtual environment
4. Run the `build-util/venv-tmp/gptest-1.1.0-cyg-venv/scripts/gptest` or `scripts/gptestui` script in the virtual environment to run the GeoProcessor.
	1. The scripts will configure the X-Window environment as needed
	2. The scripts also activate the Python virtual environment if necessary
5. Run tests with the GeoProcessor software to confirm functionality.
6. Upload the installer to the [OWF GeoProcessor Download page](http://software.openwaterfoundation.org/geoprocessor/)
by running the `build-util/3-copy-gp-to-amazon-s3.sh`.
	1. The `build-util/install/download-gp.sh` script is uploaded to the download site.
	2. The `build-util/install/install-gp-venv.sh` script is called by the above to install after downloading
	3. The files on the download site are updated to reflect the current list of downloadable products

### ![Linux](../images/linux-32.png) Creating Installer for Linux ###

**This documentation needs to be updated.  Changes to the development environment have occurred since the last public release.**

1. Run `build-util/1-create-gp-tar.sh` to create `tar.gz` and `.zip` files that contain the `site-packages` files.
	1. This creates temporary folders in `build-util/build-tmp` containing the Python files, for example:
		1. `build-util/build-tmp/tmp-gp-1.1.0` contains the needed GeoProcessor files
		2. `build-util/build-tmp/gp-1.1.0-site-package.tar.gz contains the site `geoview` package for the GeoProcessor
		3. similarly, `gptest` files are created
	2. The testing framework version (`gptest`) has QGIS references stripped from the code.
2. Run `build-util/2-create-gp-venv.sh` to create a Python virtual environment.
	1. This creates a virtual environment from the files in the previous step, for example:
		1. `build-util/venv-tmp/gptest-1.1.0-lin-venv` contains the virtual environment for
		testing framework version 1.1.0 for Linux
		2. `build-util/venv-tmp/gptest-1.1.0-lin-venv.tar.gz` is the installer that can be deployed to a Linux environment
	2. Necessary components are also installed using `pip`.
3. More frequently, when code or other source files are edited and need to be tested in Linux, run `build-util/2-update-gp-venv.sh` to
	run step 1 and parts of step 2 that copy source code and scripts to the virtual environment
4. Run the `build-util/venv-tmp/gptest-1.1.0-lin-venv/scripts/gptest` or `scripts/gptestui` script in the virtual environment to run the GeoProcessor.
	1. The scripts will configure the X-Window environment as needed
	2. The scripts also activate the Python virtual environment if necessary
5. Run tests with the GeoProcessor software to confirm functionality.
6. Upload the installer to the [OWF GeoProcessor Download page](http://software.openwaterfoundation.org/geoprocessor/)
by running the `build-util/3-copy-gp-to-amazon-s3.sh`.
	1. The `build-util/install/download-gp.sh` script is uploaded to the download site.
	2. The `build-util/install/install-gp-venv.sh` script is called by the above to install after downloading
	3. The files on the download site are updated to reflect the current list of downloadable products

### ![Windows](../images/windows-32.png) Creating Installer for Windows ###

The following describes the process to create the Windows installer.

1. **Develop within PyCharm as normal**.  This uses a Python virtual environment created from a specific version of QGIS.
The repository `scripts/gpuidev.bat` batch file is typically used to run the GeoProcessor.
2. **Create an installer**:
Run `build-util/2-create-gp-venv.bat` to create a Python virtual environment and installer zip file.
This creates a virtual environment using installed standalone QGIS version,
necessary third-party Python packages (Pandas, etc.), and
GeoProcessor from the development files, for example:
	1. `build-util/venv-tmp/gp-1.1.0-win-qgis-3.10-venv` contains the virtual environment for
	GeoProcessor version 1.1.0 for Windows and QGIS version 3.10.
	2. `build-util/venv-tmp/gp-1.1.0-win-qgis-3.10-venv.zip` is the zip file created from above step
	and can be unzipped in a Windows environment.
	3. The virtual environment `PYTHONPATH` is configured to use standalone QGIS and
	provides a folder structure for GeoProcessor `Lib\site-packages` (for `geoprocessor` module)
	and `Scripts` folder (for `gp.bat` and `gpui.bat`).
3. **Optionally - Copy files without creating the virtual environment**:
	* **This is particularly useful when iterating on a detail when preparing for a release.  Step 2 must have been executed at least once.**
	* The above folder can be updated with current development files using the `build-util/2-update-gp-venv.bat` batch file.
	* The `2-update-gp-venv.bat` batch file copies source code and scripts to the virtual environment without recreating the virtual environment.
	* The `2-update-gp-venv.bat` batch file **does not** create the zip file, which is needed to upload to the GeoProcessor downloads page.
	* Run the `2-create-gp-venv.bat` batch file (step 2 above) to create the installer for deployment.
4. **Run the GeoProcessor**:
	* The batch files will configure the QGIS environment and also make Python aware of the GeoProcessor files in the virtual environment.
	* **Development environment:** `build-util/venv-tmp/gp-1.1.0-win-gis-3.10-venv/scripts/gp.bat` or `gpui.bat`.
	* **Deployed environment:** `Scripts/gpui.bat`
5. **Run tests**:  Run automated tests with the GeoProcessor software to confirm functionality.
The results of running tests in the development should be the same as in the deployed environment.
If not, there may be a compatibility issue between the environments that needs to be resolved.
6. **Upload the installer** to the [OWF GeoProcessor Download page](http://software.openwaterfoundation.org/geoprocessor/).
	1. Run the `build-util/3-copy-gp-win-to-amazon-s3.sh` script to upload the latest Windows installer.
	2. Run the `build-util/3-copy-gp-to-amazon-s3.sh` script to upload a Cygwin/Linux version and update the
	catalog file - this is necessary because the Windows batch file above does not create the catalog file or `index.html` file.
	This script, when run on Cygwin, will also update the Windows installer zip file.
	Therefore, prepare the Windows installer file first and then process the Cygwin installer.
	**Need to fix this so that only Windows installer can be uploaded - split out the catalog file code into a separate script.**
7. **Test the installer and installed GeoProcessor**.  Download the Windows installer from the
	[GeoProcessor Downloads](http://software.openwaterfoundation.org/geoprocessor/) page.
	1. Then run the `Scripts\gp.bat` or `Scripts\gpui.bat` batch file.
	2. Run tests again to confirm functionality.
