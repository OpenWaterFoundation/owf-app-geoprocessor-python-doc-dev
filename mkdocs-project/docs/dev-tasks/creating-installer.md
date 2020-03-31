# GeoProcessor / Development Tasks / Creating Installer #

The GeoProcessor is not packaged via a `pip` or `pipenv` installer (or `apt-get` on Linux).
The deployment process uses a Python virtual environment.

The GeoProcessor software can then be installed as per the
[User Documentation](http://learn.openwaterfoundation.org/owf-app-geoprocessor-python-doc-user/appendix-install/install/).

Installers are created for different operating systems:

* [Creating Installer for Cygwin](#creating-installer-for-cygwin)
* [Creating Installer for Linux](#creating-installer-for-linux)
* [Creating Installer for Windows](#creating-installer-for-windows)

---------------

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

The installer for Windows packages the development files without modification
and is primarily targeted to the full QGIS distribution (`gp` rather than `gptest`).

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
3. **Optionally - test without building zip file**:  To test `build-util/venv-tmp/gp-1.1.0-win-qgis-3.10-venv` with
current development files without rebuilding the zip file, run `build-util/2-update-gp-venv.bat`.
	* The batch file copies source code and scripts to the virtual environment without recreating the virtual environment.
	* This batch file **does not** re-create the zip file, which is needed to upload to the GeoProcessor downloads page.
	* Run the `2-create-gp-venv.bat` batch file (step 2 above) to create the installer for deployment.
4. **Run the GeoProcessor**:
	* The batch files will configure the QGIS environment and also make Python aware of the GeoProcessor files in the virtual environment.
	* **Development environment:** `build-util/venv-tmp/gp-1.1.0-win-gis-3.10-venv/scripts/gp.bat` or `gpui.bat`.
	* **Deployed environment:** `Scripts/gpui`
5. **Run tests**:  Run tests with the GeoProcessor software to confirm functionality.
The results of running tests in the development should be the same as in the deployed environment.
If not, there may be a compatibility issue between the environments that needs to be resolved.
6. **Upload the installer** to the [OWF GeoProcessor Download page](http://software.openwaterfoundation.org/geoprocessor/).
	1. Run the `build-util/3-copy-gp-win-to-amazon-s3.sh` script to upload the latest Windows installer.
	2. Run the `build-util/3-copy-gp-to-amazon-s3.sh` script to upload a Cygwin/Linux version and update the
	catalog file - this is necessary because the script above does not create the catalog file or `index.html` file.
	This script, when run on Cygwin, will also update the Windows installer zip file.
	Therefore, prepare the Windows installer file first and then process the Cygwin installer.
7. **Test the installer and installed GeoProcessor**.  Download the Windows installer from the
	[GeoProcessor Downloads](http://software.openwaterfoundation.org/geoprocessor/) page.
	1. Then run the `Scripts\gp.bat` or `Scripts\gpui.bat` batch file.
	2. Run tests again to confirm functionality.
