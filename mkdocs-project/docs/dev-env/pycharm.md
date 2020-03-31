# GeoProcessor / Development Environment / PyCharm #

* [Introduction](#introduction)
* [Alternatives to PyCharm](#alternatives-to-pycharm)
* [Install PyCharm](#install-pycharm)
* [Script to Run PyCharm](#script-to-run-pycharm)
* [Configure PyCharm](#configure-pycharm)
* [Update PyCharm](#update-pycharm)
* [Update PyCharm to use New Python](#update-pycharm-to-use-new-python)

-------------------

## Introduction ##

This section provides background on using PyCharm for to develop the GeoProcessor.

PyCharm is the Python integrated development environment tool that has been chosen by
the Open Water Foundation for GeoProcessor development.
Other developers may use other tools such as Eclipse/PyDev if they desire but such tools have not been evaluated
by the Open Water Foundation.
The PyCharm Community Edition is adequate for development.
The GitHub repository for the project is used as the PyCharm project folder
and PyCharm project files are ignored using `.gitignore`.
This means that the developer must set up the PyCharm project themselves rather than
relying on PyCharm project files in the repository.
This approach has been chosen because:

* Changes made to PyCharm files by one developer won't impact other developers.
* It is the least prescriptive to the developer community, allowing different PyCharm configurations and use of other IDEs.
* Developers are expected to at least know how to set up a project to gain an appreciation of project configuration.

The following diagram illustrates how the PyCharm software is used with QGIS and Python (upper right part of diagram).

**<p style="text-align: center;">
![gp-python-config](images/gp-python-config.png)
</p>**

**<p style="text-align: center;">
GeoProcessor / GGIS / Python Configuration (<a href="../images/gp-python-config.png">see full-size image</a>)
</p>**

The PyCharm IDE runs Python in the development environment,
and therefore each project must be configured to know which Python interpreter to use.
PyCharm is typically configured to use a Python version in the virtual environment folder (`venv`) that is
set up when the GeoProcessor Python project is setup, as shown in the following figure.
The following image illustrates the virtual environment naming convention used for GeoProcessor,
in order avoid confusion about QGIS and Python version.

**<p style="text-align: center;">
![pycharm-settings-project-interpreter](images/pycharm-settings-project-interpreter.png)
</p>**

**<p style="text-align: center;">
PyCharm Project Python Interpreter (<a href="../images/pycharm-settings-project-interpreter.png">see full-size image</a>)
</p>**

The Python distributed with QGIS is used in development and deployed GeoProcessor environments,
rather than using the user's or system Python.
The Python to use is set by run scripts using the `PYTHONHOME` environment variables.
QGIS, GeoProcessor, and third-party libraries are made known to PyCharm using the `PYTHONPATH` environment variables.
A run script is used to run PyCharm (see the [Script to Run PyCharm](#script-to-run-pycharm) section).
PyCharm when run from the ***Start*** menu will not have the benefit of such configuration and will not
work for the GeoProcessor development.

The GeoProcessor is normally distributed using a Python virtual environment so that users don't
have to install any Python or other software.
See the [Development Tasks / Creating Installer](../dev-tasks/creating-installer.md) documentation.

## Alternatives to PyCharm ##

The PyCharm Community Edition is used for GeoProcessor development at the Open Water Foundation.
However, other developers may prefer to use other Python development tools.
Keep the following in mind:

1. This Developer Documentation has been created assuming that PyCharm is used.
Using other tools will require similar configuration.
This documentation can be updated with examples for other tools.
2. PyCharm project files are omitted from the repository using the main `.gitignore` file.
Implementing other development environment tools should also take care to omit developer-specific and
dynamic files from the repository.
3. The development environment does not limit using build-in Python tools such as IDLE.
4. Use of alternate tools should continue to follow project standards, such as PEP code formatting.

## Install PyCharm ##

This section describes how to install the PyCharm 64-bit Community Edition:

1. Download a recent PyCharm Community Edition from the [PyCharm Download page](https://www.jetbrains.com/pycharm/download/#section=windows) - select Windows
2. The installer has the option of creating a desktop shortcut.  Do this for 64-bit launcher.
3. It is not necessary to associate `.py` files with PyCharm, but also OK to make the association.
4. Otherwise, accept the defaults.
5. The installer appears to be intelligent enough to carry forward configuration information from previous installations of PyCharm.

This will install PyCharm into a folder similar to `C:\Program Files\JetBrains\PyCharm Community Edition 2018.1.2`
(new versions are released periodically).
Once installed the software may periodically ask to install updates.
Doing so does not appear to change the original install folder (even if the version changes)...updates seem
to install in the same folder.
It may be that an update only creates a new folder for a new year.
See the next section for information about running PyCharm with a
run script that uses a configuration for QGIS and GeoProcessor development.

## Script to Run PyCharm ##

As indicated in previous sections, it is necessary to use the QGIS Python and modules in the GeoProcessor.
PyCharm must also use QGIS Python interpreter and packages in order to allow for code inspection and module imports.
Therefore, a batch file (Windows) and script (Linux) is used to configure the environment and run PyCharm.
To start PyCharm, run one of the following scripts,
located in the `build-util/` folder in the repository.

**<p style="text-align: center;">
Scripts and Batch Files to Run PyCharm
</p>**

| **Windows Batch File**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | **Linux Script** | **Description** |
| -- | -- | -- |
| `run-pycharm-ce-for-qgis.bat` | None yet | Searches for recent Pycharm Community Edition version to run, configures the environment for QGIS and GeoProcessor development Python, and starts PyCharm. |

## Configure PyCharm ##

After installing PyCharm, a few additional configuration changes should be made:

* Previously, Google docstring format was used as a standard
(configured in ***File / Settings*** and then ***Tools / Python Integrated Tools / Docstrings***.
However, the default docstring format is now used, which uses the format:

```
Args:
    some_arg(str):  Description

Returns:
    str:  Property value or None if not found.

Raises:
    RuntimeError: If there was a logic error.
```

## Update PyCharm ##

PyCharm periodically provides a notification in the user interface that an update is available
and provides a link to update and restart the software.
There is generally no reason to postpone updates, so follow the instructions to update.

The update appears to always update files in the previous version regardless of the installation folder.
This may mean that the PyCharm version indicated in ***Help / About*** is not consistent with the installation folder.
This does not seem to be an issue.
The [script to run PyCharm](#script-to-run-pycharm) checks for multiple PyCharm version and runs the latest found installed version.

## Update PyCharm to use New Python ##

**This documentation needs to be updated.
The current convention for GeoProcessor development is to use a Python virtual environement configuration and
corresponding name that is specific enough that it should not be updated.
If necessary, a new virtual environment can be configured with corresponding name that reflects QGIS and Python version.**

It may be necessary to update the Python that is used in PyCharm,
for example if a new version of QGIS is installed.
In this case, a new virtual environment can be created and the project settings updated to use the new virtual environment.
Update the virtual environment as follows.

First start PyCharm for the GeoProcessor.
Then select the project settings in PyCharm with ***File / Settings***.
Then select the ***Project Interpreter*** item, as shown below.

**<p style="text-align: center;">
![Update Python 1](images/update-pycharm-python1.png)
</p>**

**<p style="text-align: center;">
PyCharm Project Interpreter Configuration (<a href="../images/update-pycharm-python1.png">see full-size image</a>)
</p>**

**Need to evaluate whether the warning shown at the bottom of the above dialog is significant.**
The `C:\OSGeo4W64\apps\Python37` and `C:\OSGeo4W64\apps\bin` folders do not include `pip3` by default.

Click on the gear icon in the upper right and select ***Show All...***, which will display the following.

**<p style="text-align: center;">
![Update Python 2](images/update-pycharm-python2.png)
</p>**

**<p style="text-align: center;">
Project Interpreter List (<a href="../images/update-pycharm-python2.png">see full-size image</a>)
</p>**

Clicking on the + icon in the upper right will show the following dialog to add a new Python interpreter.
In this case the error is due to QGIS having been updated to version 3.7 and the
`C:\OSGeo4W64\apps\Python36` folder no longer exists.

**<p style="text-align: center;">
![Update Python 3](images/update-pycharm-python3.png)
</p>**

**<p style="text-align: center;">
Add Python Interpreter (<a href="../images/update-pycharm-python3.png">see full-size image</a>)
</p>**

To create a new virtual environment,
use the ***Base Interpreter ...*** button to select a new QGIS Python, for example select Python37 as shown below.

**<p style="text-align: center;">
![Update Python 4](images/update-pycharm-python4.png)
</p>**

**<p style="text-align: center;">
Specify Base Python Interpreter (<a href="../images/update-pycharm-python4.png">see full-size image</a>)
</p>**

Press ***OK*** to create the virtual environment in the folder shown above.
This may take a minute or two.
This will only copy the core Python executable programs and files, but not `site-packages` or other third-party packages.
Once the virtual environment is created, it will be listed in available ***Project Interpreters*** as shown in the following figure.

**<p style="text-align: center;">
![Update Python 5](images/update-pycharm-python5.png)
</p>**

**<p style="text-align: center;">
Project Interpreters After Adding an Interpreter (<a href="../images/update-pycharm-python5.png">see full-size image</a>)
</p>**

Select the new virtual environment and press ***OK***.
The following dialog will be shown showing the installed packages.

**<p style="text-align: center;">
![Update Python 5](images/update-pycharm-python6.png)
</p>**

**<p style="text-align: center;">
Packages Intalled for an Interpreter (<a href="../images/update-pycharm-python6.png">see full-size image</a>)
</p>**

Press ***OK*** to confirm selection of the new Python virtual environment.
It may take a few minutes for the project to refresh using the new virtual environment.

To confirm which version of Python is running,
run the `geoprocessor/app/printenv.py` script in PyCharm (right click and run).
Output will be similar to the following.
Note that the Python being used is the virtual environment and that the `sys.path`
includes QGIS libraries using old-style 8.3 paths.
The Python path is defined in the `build-util/run-pycharm-ce-for-qgis.bat` file to run in Windows.

```
Python Properties:
    Python executable (.executable): C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python\venv-qgis-python37\Scripts\python.exe
    Python Version (sys.version): 3.7.0 (v3.7.0:1bf9cc5093, Jun 27 2018, 04:59:51) [MSC v.1914 64 bit (AMD64)]
    Python Path (sys.path):
        C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python
        C:\OSGEO4~2\apps\Python37\lib\site-packages
        C:\OSGEO4~2\apps\qgis\python
        C:\OSGEO4~2\apps\qgis\python\plugins
        C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python\venv-qgis-python37\Scripts\python37.zip
        C:\OSGEO4~2\apps\Python37\DLLs
        C:\OSGEO4~2\apps\Python37\lib
        C:\OSGeo4W64\apps\Python37
        C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python\venv-qgis-python37
        C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python\venv-qgis-python37\lib\site-packages
```

Similar information can be viewed in the GeoProcessor UI using the ***Help / Software/System Information*** menu item.
