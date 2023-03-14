# GeoProcessor / Development Environment / Python ##

This documentation describes how to install Python software and third party packages.

*   [Introduction](#introduction)
*   [Install Python](#install-python)
    +   [QGIS Python](#qgis-python) - installs when QGIS is installed
    +   [Development Environment Virtual Environment Python](#development-environment-virtual-environment-python) - when PyCharm project is created
    +   [System/User Python](#systemuser-python) - needed for MkDocs documentation
    +   [GeoProcessor Deployed Virtual Environment Python](#geoprocessor-deployed-virtual-environment-python) - when installer is created
*   [Install Additional Python Packages](#install-additional-python-packages)
    +   [QGIS Python Additional Packages](#qgis-python-additional-packages) - when QGIS is installed/updated
    +   [Development Environment Virtual Environment Additional Packages](#development-environment-virtual-environment-additional-packages) - when PyCharm project is created
    +   [System/User Python Additional Packages](#systemuser-python-additional-packages) - needed for MkDocs documentation
    +   [GeoProcessor Deployed Virtual Environment Additional Packages](#geoprocessor-deployed-virtual-environment-additional-packages) - when installer is created
    +   [Troubleshooting Installing Additional Python Packages](#troubleshooting-installing-additional-python-packages) - for example, pip SSL issues
*   [Resources](#resources)

-----------

## Introduction ##

The GeoProcessor is written in Python and uses the QGIS PyQGIS modules to process and display data.
Multiple instances of Python are installed to support GeoProcessor development and deployment.
The following diagram illustrates how the PyCharm software is used with QGIS and Python (upper right part of diagram).

**<p style="text-align: center;">
![gp-python-config](images/gp-python-config.png)
</p>**

**<p style="text-align: center;">
GeoProcessor / GGIS / Python Configuration (<a href="../images/gp-python-config.png">see full-size image</a>)
</p>**

Python installed instances that are used for GeoProcessor include the following.
Version numbers shown are for example and will change as software is updated.

**<p style="text-align: center;">
Python Instances used with GeoProcessor
</p>**

| **Python Instance Location**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | **How Used** | **Additional Packages**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
| -- | -- | -- |
| **QGIS**<br>(e.g. `C:\Program Files\`<br>`QGIS 3.10\`<br>`apps\Python37\`) | <ul><li>initialize new Pycharm virtual environment project Python base interpreter to edit code and run the GeoProcessor in PyCharm</li><li>initialize Python virtual environment when creating GeoProcessor installer</li><li>used by `gpdev.bat` in the development environment to run the GeoProcssor</li></ul> | <ul><li>`virtualenv` - to allow creating virtual environments from QGIS Python</li></ul> |
| **PyCharm** development virtual environment (`build-util\venv-tmp\...`)| <ul><li>created using `virtualenv` **from QGIS Python**</li><li>used by PyCharm when developing and running code</li><li>**may** be used to create installer when troubleshooting QGIS Python issues for installer</li></ul> | <ul><li>`pandas`</li><li>`openpyxl`</li><li>`requests[security]`</li><li>`SQLAlchemy`</li><li>`virtualenv`</li></ul> |
| **System/User** | <ul><li>Often installed independent of GeoProcessor for general use</li><li>MkDocs Markdown documentation for static websites</li><li>**may** be used to create installer when troubleshooting QGIS Python issues for installer</li></ul> | <ul><li>`mkdocs`</li><li>`mkdocs-material`</li><li>`virtualenv`</li></ul> |
| **GeoProcessor** deployed virtual environment<br>(`gp-1.3.3-win-qgis-3.10-venv`)| <ul><li>created using `virtualenv` **from QGIS Python**</li><li>GeoProcessor runtime environment accessed with `gpui.bat` and `gp.bat` batch files.</li></ul> | <ul><li>`pandas`</li><li>`openpyxl`</li><li>`requests[security]`</li><li>`SQLAlchemy`</li></ul> |

The above shows that although there are multiple instances of Python installed,
the installations should be straightforward.

The deployed GeoProcessor environment uses a Python virtual environment with Python that is compatible
with the operating system.
Therefore it is necessary to install Python and third-party packages in Windows, Cygwin, and Linux.
Windows 10 is currently the primary development and deployed environment.
Testing and secondary development occurs on Cygwin and Linux and will increase over time as the core
product is deployed on more systems.

## Install Python ##

Python must be installed consistent with the development environment and also
support the QGIS and testing framework variants of the GeoProcessor.

### QGIS Python ###

Python for QGIS is installed when installing QGIS.
See the [QGIS installation documentation](qgis.md).

For example, the standalone QGIS Python on Windows is located in a folder similar to:

```
C:\Program Files\QGIS 3.10\apps\Python37
```

The GeoProcessor software packaging for a deployed system is designed to **not** require that additional Python packages are installed in QGIS Python.
However, for GeoProcessor software developers, it is necessary to install the `virtualenv` package to streamline
the QGIS Python to be used as the base interpreter for new virtual environments.

*   See the [QGIS Python Additional Packages](#qgis-python-additional-packages) section of this page

### Development Environment Virtual Environment Python ###

The development environment virtual environment Python is copied from the QGIS Python
when creating the Pycharm project virtual environment.
See the [New Developer / Setup GeoProcessor PyCharm Project](../dev-new/dev-new.md#setup-geoprocessor-pycharm-project) documentation.

### System/User Python ###

GeoProcessor code development uses a virtual environment created from QGIS Python.
However, a separate system/user Python is used for MkDocs for documentation,
consistent with other Open Water Foundation development efforts.
If necessary, the MkDocs run scripts could be updated to use the development Python.

A system Python can be installed in a folder such as `C:\Python37` on Windows.
However, installing in a user's account is recommended (e.g., `C:\Users\user\AppData\Local\Programs\Python\Python37` on Windows 10).
The latter is recommended by the installer dialog and its documentation for newer Python versions
to isolate potential negative impacts on the system from Python
packages downloaded from the internet.
Installing in user files also allows packages to be installed without administrator privileges.
See the following sections for information about installing Pythons.

#### ![Cygwin](../images/cygwin-32.png) Cygwin ####

Use the following to see which version of Python is installed:

```sh
$ which python3
$ python3 --version
```

Use the Cygwin setup tool to install Python as part of the Cygwin setup.
See the [Cygwin Installation](cygwin.md) documentation.
The version should be as near as possible to that used by QGIS although the Cygwin setup tool will
only provide selections for `python3`, not a specific version.
The latest Cygwin Python 3 version is typically sufficient to run MkDocs and is
generally compatible with GeoProcessor.

#### ![Linux](../images/linux-32.png) Linux ####

Use the following to see which version of Python is installed:

```sh
$ which python3
$ python3 --version
```

Use the `apt-get` program to install the Python 3 that is supported on the system.
If may be necessary to do a custom install if Python 3.7 is not available for the operating system.
The version should be as near as possible to that used by QGIS.
The latest Linux Python 3 version is typically compatible with GeoProcessor.
Running the automated tests can confirm compatibility.

#### ![Windows](../images/windows-32.png) Windows ####

Use the following to determine which version of Python is installed and available in `PATH` folders
(although other versions may be installed that are not in the `PATH`).

```sh
> where python3
> python3 --version
```

The version of Python that is installed for testing framework and other uses
should be as close as possible to the QGIS version, which is 3.7 as of QGIS 3.4.3.
See the `C:\OSGeo4W64\apps` folder on Windows to see which version of Python is used.

If not installed, a typical Python install should be done as per Python installer instructions.

**Note that on Windows, trying to run `python` or `python3` directly may fail.**
This is because the Python version(s) that are installed may not have resulted in changing the `PATH`
environment variable and consequently the software can't be run from the command shell with just the program name.
To address this issue, recent versions of Python are distributed with `py.exe` program that is installed in
a system folder (e.g., `C:\Windows`) that is always in the `PATH`:

```
> where py
C:\Windows\py.exe
```

The `py` program provides a unified interface to Python and automatically finds Python installed in standard locations.
Use `py --help` to see usage information.
To be certain about which Python is being run, use an option like `py -3.7`,
where the number agrees with the QGIS Python version for consistency.
Windows batch files that run Python use the `py` generically
or specify the path a specific such as development or deployed Python.

Download and install Python for Windows.
The version should be as near as possible to that used by QGIS, at least to the major version such as `3.17`
(see the [Development Environment / QGIS](qgis.md) documentation.
If necessary, install QGIS first to confirm the Python version that is used.  See:

*   [GeoProcessor Development Environment / QGIS](qgis.md)
*   [Python Releases for Windows](https://www.python.org/downloads/windows/)
*   [Open Water Foundation / Learn Python](http://learn.openwaterfoundation.org/owf-learn-python/dev-env/python/python/)

### GeoProcessor Deployed Virtual Environment Python ###

The GeoProcessor deployed virtual environment Python is copied from the QGIS Python.
See the [Development Tasks / Creating Installer](../dev-tasks/creating-installer.md) documentation.

## Install Additional Python Packages ##

After installing Python in one of the instances listed in the [Introduction](#introduction) section,
it is necessary to install additional Python packages that enable necessary functionality in Python environment.
The packages that are required vary depending on the Python installation's role in the GeoProcessor development and deployment life cycle.
Where possible, such as when creating the GeoProcessor installer, the installation of packages is automated.

**Install additional packages after installing the necessary software.
For example, install QGIS as per the main installation steps and then install its 
additional Python packages using the following documentation.**

### QGIS Python Additional Packages ###

The GeoProcessor uses some third-party packages.
Most of these packages are installed in the development (PyCharm) virtual environment and the deployed virtual environment
so that the original QGIS Python environment is not impacted.

However, because the QGIS Python instance is used to create the development and deployed Python virtual environment instances,
it is necessary to install the `virtualenv` package in the QGIS Python environment, as described below.
It is possible to use the built-in Python `venv` module rather than `virtualenv` and this approach will be tested in the future,
in which case installing `virtualenv` in QGIS Python will not be required.

The following describes how to install additional Python packages in QGIS Python.
Because standalone QGIS is installed into `C:\Program Files\QGIS 3.10` (or similar) with administrator privileges,
additional packages must also be installed with administrator privileges.

**The following instructions are for QGIS 3.10 but other versions are similar.**

1.  Open ***Start / QGIS 3.10 / OSGeo4W Shell*** (for standalone QGIS install) or
    ***Start / OSGeo4W / OSGeo4W Shell*** (for OSGeo4W QGIS install) to start an environment compatible with QGIS Python:
    *   **If OSGeo4W Shell can be run as Administrator** - Ideally it should be possible to right-click on the menu and then do ***More / Run as administrator...*** (or similar).
        If this is not available, use the next option described below.
    *  **If OSGeo4W Shell cannot be run as Administrator** - More steps are required, described for standalone QGIS 3.10:
        1.  The ***Start / QGIS 3.10 / OSGeo4W Shell*** menu item is a shortcut to the following
            location:  `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\QGIS 3.10`,
            which can be determined by right-clicking on the menu item and selecting ***More / Open file location***.
        2.  Then right-click on the `OSGeo4W Shell` shortcut and select ***Properties***.
            The ***Shortcut*** tab will show a target similar to `C:\Program Files\QGIS 3.10\OSGeo4W.bat`.
        3.  Because this is a batch file, it can be run in a `cmd` shell that is run as administrator.
            Thefore, use the ***Start / Windows System / Command Prompt*** menu with right-click ***More / Run as administrator...***
            to start a command shell running with administrative privileges.
        4.  In the ***Command Prompt*** window, change to the `C:\Program Files\QGIS 3.10` folder (or version of interest).
        5.  Run the `OSGeo4W.bat` batch file.
            Running the `set` command afterwards should list environment variables such as `OSGEO4W_ROOT`,
            indicating that the shell has been configured for QGIS.
2.  Change to the `C:\Program Files\QGIS 3.10\apps\Python37` (or similar) folder.
    This is necessary because Python is not in the `PATH` at this point.
    Use `where python` to confirm which Python will be found.
3.  Install the Python package(s) indicated in the following table.
    If errors occur such as `pip` requiring SSL, see the [Troubleshooting Installing Additional Python Packages](#troubleshooting-installing-additional-python-packages) section.

**<p style="text-align: center;">
Additional Packages for QGIS Python
</p>**

|**Software Package Name**|**Source Link(s)**|**How Used Within GeoProcessor**| **Command**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|
|-|-|-|-|
|virtualenv|[https://virtualenv.pypa.io/en/latest/](https://virtualenv.pypa.io/en/latest/)| Used to initialize Python virtual environments for Pycharm development environment and GeoProcessor installer. |`python -m pip install virtualenv`|

### Development Environment Virtual Environment Additional Packages ###

The development environment Python virtual environment is initialized from QGIS Python, for use in PyCharm.
The GeoProcessor uses third-party Python packages that need to be installed using standard `pip` approach.
These packages may or may not be distributed with QGIS (QGIS packages change over time).
The need for additional packages are discovered during normal development as new code components are added.
Additional packages can be installed from PyCharm;
however, doing so on the command line is more efficient and can be automated.

The following describes how to install additional packages and typically needs to occur only when setting up a new PyCharm project.

1.  In a Windows command prompt, change to the `venv/venv-qgis-3.10-python37\Scripts` folder
    (or similar, depending on versions being used).
2.  Activate the venv by running `activate.bat`.
3.  Install the packages listed in the following table.
    If errors result, such as Python SSL error, see the [Troubleshooting Installing Additional Python Packages](#troubleshooting-installing-additional-python-packages) section.
4.  Deactivate the venv by running `deactivate.bat`.
5.  Close the command prompt window.

After installing, the PyCharm ***Settings / Project / Project Interpreter*** package list will display the newly installed packages.

**<p style="text-align: center;">
Additional Python Packages for Development Virtual Environment
</p>**

|**Software Package Name**|**Source Link(s)**|**How Used Within GeoProcessor**| **Command**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|
|-|-|-|-|
|pandas|[https://pandas.pydata.org/](https://pandas.pydata.org/)|Holds and manipulates Table data.<br>**May already be installed in QGIS Python - check Project Interpreter package list in Pycharm File / Settings.**|`python -m pip install pandas`|
|OpenPyXL|[https://openpyxl.readthedocs.io/en/stable/](https://openpyxl.readthedocs.io/en/stable/)|Reads and writes Excel 2010 xlsx/xlsm files to and from Table objects.<br>**Does not seem to be installed with QGIS Python.** |`python -m pip install openpyxl`|
|requests (extended package)|[http://docs.python-requests.org/en/master/](http://docs.python-requests.org/en/master/)<br><br> [https://pypi.org/project/requests/](https://pypi.org/project/requests/)|Downloads data files within the [`WebGet`](http://software.openwaterfoundation.org/geoprocessor/latest/doc-user/command-ref/WebGet/WebGet/) command. <br><br>The `requests[security]` extension package is preferred over the core `requests` package to avoid an error that would occur when downloading a file over `https` with the [`WebGet`](http://software.openwaterfoundation.org/geoprocessor/latest/doc-user/command-ref/WebGet/WebGet/) command. The error that occurred when using the core `requests` package printed:<br>`requests.exceptions.SSLError: [Errno 1] _ssl.c:503: error:140770FC:SSL routines:SSL23_GET_SERVER_HELLO:unknown protocol`. <br>This error does not occur when utilizing the `requests[security]` extension package.<br>**The `requests` package is installed with QGIS Python but not `requests[security]`, so install it.** | `python -m pip install requests[security]`|
|SQLAlchemy|[http://www.sqlalchemy.org/](http://www.sqlalchemy.org/)|Enables connections to databases.<br>**Does not seem to be installed in QGIS Python.**|`python -m pip install SQLAlchemy`|
|virtualenv|[https://virtualenv.pypa.io/en/latest/](https://virtualenv.pypa.io/en/latest/)|Used to package the GeoProcessor runtime into an isolated Python environment when [creating an installer](../dev-tasks/creating-installer.md).<br>**Does not seem to be installed in QGIS Python.  If installed in the QGIS Python, then it will be copied when PyCharm creates its virtual environment and does not need to be reinstalled in the venv.** |`python -m pip install virtualenv`|

### System/User Python Additional Packages ###

The system/user Python installed instance is used mainly for MkDocs documentation,
and to investigate issues with the QGIS Python.
For example, standard Python installations will be newer than QGIS Python and can be used to test
whether bugs have been fixed.

#### ![Cygwin](../images/cygwin-32.png) Cygwin ####

Cygwin is often typically used to run MkDocs for documentation.
Therefore, install the following Python packages in the Cygwin system Python,
from a Cygwin terminal window:

**<p style="text-align: center;">
Additional Packages for System/User Python
</p>**

| **Package**           | **Description**                  | **Installation Command**       |
| --------------------- | -------------------------------- | ------------------------------ |
| `mkdocs`              | MkDocs documentation software.   | `pip3 install mkdocs`          |
| `mkdocs-material`     | MkDocs material theme.           | `pip3 install mkdocs-material` |
| `virtualenv`          | Python virtual environment tool. | `pip3 install virtualenv`      |

#### ![Linux](../images/linux-32.png) Linux ####

MkDocs may be used for documentation (or such documentation editing may be confined to Windows/Cygwin).
Therefore, install the following Python packages in the Linux system Python from a Linux terminal window:

**<p style="text-align: center;">
Additional Packages for System/User Python
</p>**

| **Package**           | **Description**                  | **Installation Command**       |
| --------------------- | -------------------------------- | ------------------------------ |
| `mkdocs`              | MkDocs documentation software.   | `pip3 install mkdocs`          |
| `mkdocs-material`     | MkDocs material theme.           | `pip3 install mkdocs-material` |
| `virtualenv`          | Python virtual environment tool. | `pip3 install virtualenv`      |

#### ![Windows](../images/windows-32.png) Windows ####

The system/user Python may be used to create documentation (or, see Cygwin section above),
Note that MkDocs is generally run in Cygwin but some developers may want to run in Windows.

System/user Python may be used to create the GeoProcessor as a comparison when troubleshooting QGIS python.
Install the following additional packages in a Windows command shell.

The installation commands below indicate to the general Windows `py.exe` program which specific Python version
to install, by running `pip` within the correct Python version. 

**<p style="text-align: center;">
Additional Packages for System/User Python
</p>**

| **Package**           | **Description**                  | **Installation Command**       |
| --------------------- | -------------------------------- | ------------------------------ |
| `mkdocs`              | MkDocs documentation software.   | `py -3.7 -m pip install mkdocs`          |
| `mkdocs-material`     | MkDocs material theme.           | `py -3.7 -m pip install mkdocs-material` |
| `virtualenv`          | Python virtual environment tool. | `py -3.7 -m pip install virtualenv`      |

### GeoProcessor Deployed Virtual Environment Additional Packages ###

The GeoProcessor virtual environment that is deployed via the GeoProcessor installer
is created similar to how the development virtual environment is created.
Installation of additional Python packages is automated.
See the [Development Tasks / Creating Installer](../dev-tasks/creating-installer.md) documentation section.

### Troubleshooting Installing Additional Python Packages ###

This section provides information about troubleshooting installing Python additional packages.

#### Error message: `pip is configured with locations that require TLS/SSL, however, the ssl module in Python is not available.`

This error has been seen with QGIS 3.10 and 3.26.3 and typically indicates that Python is not installed with required TLS/SSL libraries for secure communication.
This may occur when installing the `virtualenv` package that is needed by PyCharm to set up a virtual environment for development.
It is strange that Python is not distributed with these libraries by default but some versions of Python do not seem to include
and additional action is required.
The following illustrates the issue and solution.

`pip` may complain with an error like the following:

```
python -m pip install openpyxl
pip is configured with locations that require TLS/SSL, however the ssl module in Python is not available.
Collecting openpyxl
  Retrying (Retry(total=4, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError("Can't connect to HTTPS URL because the SSL module is not available.")': /simple/openpyxl/
  Retrying (Retry(total=3, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError("Can't connect to HTTPS URL because the SSL module is not available.")': /simple/openpyxl/
  Retrying (Retry(total=2, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError("Can't connect to HTTPS URL because the SSL module is not available.")': /simple/openpyxl/
  Retrying (Retry(total=1, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError("Can't connect to HTTPS URL because the SSL module is not available.")': /simple/openpyxl/
  Retrying (Retry(total=0, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError("Can't connect to HTTPS URL because the SSL module is not available.")': /simple/openpyxl/
  Could not fetch URL https://pypi.org/simple/openpyxl/: There was a problem confirming the ssl certificate: HTTPSConnectionPool(host='pypi.org', port=443): Max retries exceeded with url: /simple/openpyxl/ (Caused by SSLError("Can't connect to HTTPS URL because the SSL module is not available.")) - skipping
  Could not find a version that satisfies the requirement openpyxl (from versions: )
No matching distribution found for openpyxl
pip is configured with locations that require TLS/SSL, however the ssl module in Python is not available.
Could not fetch URL https://pypi.org/simple/pip/: There was a problem confirming the ssl certificate: HTTPSConnectionPool(host='pypi.org', port=443): Max retries exceeded with url: /simple/pip/ (Caused by SSLError("Can't connect to HTTPS URL because the SSL module is not available.")) - skipping
```

This is because the venv Python does not include `ssl` module.
To understand the issue, test on a system/user Python instance:

```
C:\>py
Python 3.7.2 (tags/v3.7.2:9a3ffc0492, Dec 23 2018, 23:09:28) [MSC v.1916 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import ssl
>>> quit()
```

Try the same using standalone `C:\Program Files\QGIS 3.10\apps\Python37`:

```
C:\Program Files\QGIS 3.10\apps\Python37>python
Python 3.7.0 (v3.7.0:1bf9cc5093, Jun 27 2018, 04:59:51) [MSC v.1914 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import ssl
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "C:\Program Files\QGIS 3.10\apps\Python37\lib\ssl.py", line 98, in <module>
    import _ssl             # if we can't import it, let the error propagate
ImportError: DLL load failed: The specified module could not be found.
>>> quit()
```

And, on the GeoProcessor PyCharm project venv Python that was created from QGIS Python:

```
(venv-qgis-3.10-python37) C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python\venv\venv-qgis-3.10-python37\Scripts>python
Python 3.7.0 (v3.7.0:1bf9cc5093, Jun 27 2018, 04:59:51) [MSC v.1914 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import ssl
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "C:\Program Files\QGIS 3.10\apps\Python37\lib\ssl.py", line 98, in <module>
    import _ssl             # if we can't import it, let the error propagate
ImportError: DLL load failed: The specified module could not be found.
>>> quit()
```

See the [bugs.python.org article](https://bugs.python.org/issue39344).
Following the advice in this article, copy from a personal Python 3.7 `AppData/Local/Programs/Python/Python37/` the files 
`libcripto-1_1-x64.dll` and `libssl_1_1-64.dll` to the venv `Scripts` folder.
Then get the following, indicating that `SSL` is loading:

```
(venv-qgis-3.10-python37) C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python\venv\venv-qgis-3.10-python37\Scripts>python
Python 3.7.0 (v3.7.0:1bf9cc5093, Jun 27 2018, 04:59:51) [MSC v.1914 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import ssl
>>> quit()
```

To facilitate Python installations needed by the GeoProcessor, the libraries have been added to the GeoProcessor repository in the
`resources/installer/win/ssl` folder.
However (for example for installing venv for the QGIS 3.26.3 Python),
it may also be possible to copy `libcrypto-1_1.dll` and `libssl-1_1-x64.dll` from the main `QGIS 3.x\bin` folder to 
the `QGIS 3.x\apps\Python3x\DLLs` folder, which is where the `_ssl.pyd` file exists.
Note that other copies of these libraries may exist in that folder (e.g., `libcrypto-1_1.dll` and `libssl-1_1.dll`).
Use the `diff` command to compare the files to see if they are actually different.
Sometimes is is necessary to restart the computer because DLL files seem to be cached in memory.

**Experience has shown that leaving these libraries in the instance can cause a problem running GeoProcessor,
resulting in the following error.  Therefore, remove the libraries once the `pip` tasks are complete.
If `pip` needs to be run later, the libraries can be copied again.
Hopefully this issue is resolved with future versions of Python and QGIS and does not require these additional steps.**

```
Traceback (most recent call last):
  File "C:\PROGRA~1\QGIS3~1.10\apps\Python37\lib\runpy.py", line 193, in _run_module_as_main
    "__main__", mod_spec)
  File "C:\PROGRA~1\QGIS3~1.10\apps\Python37\lib\runpy.py", line 85, in _run_code
    exec(code, run_globals)
  File "C:\Users\sam\gp-1.3.0.dev-win-qgis-3.10-venv\Lib\site-packages\geoprocessor\app\gp.py", line 39, in <module>
    from geoprocessor.commands.testing.StartRegressionTestResultsReport import StartRegressionTestResultsReport
  File "C:\Users\sam\gp-1.3.0.dev-win-qgis-3.10-venv\Lib\site-packages\geoprocessor\commands\testing\StartRegressionTestResultsReport.py", line 31, in <module>
    import geoprocessor.util.validator_util as validator_util
  File "C:\Users\sam\gp-1.3.0.dev-win-qgis-3.10-venv\Lib\site-packages\geoprocessor\util\validator_util.py", line 27, in <module>
    import ogr
  File "C:\Program Files\QGIS 3.10\apps\Python37\Lib\site-packages\ogr.py", line 2, in <module>
    from osgeo.gdal import deprecation_warn
  File "C:\Program Files\QGIS 3.10\apps\Python37\Lib\site-packages\osgeo\__init__.py", line 41, in <module>
    _gdal = swig_import_helper()
  File "C:\Program Files\QGIS 3.10\apps\Python37\Lib\site-packages\osgeo\__init__.py", line 24, in swig_import_helper
    _mod = imp.load_module('_gdal', fp, pathname, description)
  File "C:\PROGRA~1\QGIS3~1.10\apps\Python37\lib\imp.py", line 243, in load_module
    return load_dynamic(name, filename, file)
  File "C:\PROGRA~1\QGIS3~1.10\apps\Python37\lib\imp.py", line 343, in load_dynamic
    return _load(spec)
ImportError: DLL load failed: The specified procedure could not be found.
Exiting gp.bat with exit code 1
```

## Resources ##

The following are useful resources for understanding QGIS Python configuration.

*   [Stack Overflow:  OSGeo4W shell with python3](https://gis.stackexchange.com/questions/273870/osgeo4w-shell-with-python3).
