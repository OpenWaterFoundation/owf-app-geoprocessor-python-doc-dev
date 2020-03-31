# GeoProcessor / Development Environment / Python ##

This documentation describes how to install Python software and third party packages.

* [Introduction](#introduction)
* [Install Python](#install-python)
	+ [Python for QGIS](#python-for-qgis) - installs when QGIS is installed
	+ [Python Outside of QGIS](#python-outside-of-qgis) - needed for MkDocs and creating virtual environment for installer
* [Install Additional Packages](#install-additional-packages)
	* [Packages Needed for the Development Environment](#packages-needed-for-the-development-environment)
	* [Packages Needed by GeoProcessor](#packages-needed-by-geoprocessor)

-----------

## Introduction ##

Multiple versions of Python are installed to support GeoProcessor development and deployment.
Python versions that are used include:

* QGIS - Python 3.7 (or similar, depending on QGIS version)
installed with QGIS and will be used to initialize the Pycharm virtual environment
to edit code and run the GeoProcessor in PyCharm.
It is also used to initialize the virtual environment for deployment of full QGIS `gp` installations.
* Testing Framework - Python 3.7 (or similar, depending on QGIS version)
is used to create a virtual environment for the `gptest` testing framework,
which has no dependency on QGIS:
	+ for Windows, use a Python version consistent with QGIS to avoid issues
	+ for Cygwin, the latest Python 3 - deal with issues as necessary
	+ for Linux, the latest stable Python 3 - deal with issues as necessary
* Development Tools - Python 3 is used by MkDocs to process Markdown documentation into static websites
(typically use a system or user-installed Python 3) that may be the same as above.

The deployed GeoProcessor environment uses a Python virtual environment with Python that is compatible
with the operating system.
Therefore it is necessary to install Python and third-party packages in Windows, Cygwin, and Linux.
Windows 10 is currently the primary development environment and testing and secondary development occurs on Cygwin and Linux.
See the sections below discussing the installation of each version.

## Install Python ##

Python must be installed consistent with the development environment and also
support the QGIS and testing framework variants of the GeoProcessor.

### Python for QGIS ###

Python for QGIS is installed when installing QGIS.
See the [QGIS installation documentation](qgis.md).

### Python Outside of QGIS ###

A Python installation outside of QGIS is used for MkDocs and as the base interpreter for creating virtual machines.

In this case, Python can be installed in a shared location (e.g., `C:\Python37` on Windows),
or in a user's account (e.g., `C:\Users\user\AppData\Local\Programs\Python...` on Windows 10).
The latter is recommended (by the installer dialog and its documentation) for newer Python versions
to isolate potential negative impacts on the system from Python
packages downloaded from the internet (less of an issue for well-respected packages).

The installation location of Python core software and third-party packages has evolved with each Python version.
Unfortunately, this can lead to confusion.
Consequently, within the GeoProcessor development environment,
it is recommended to use a script to run each Python application,
which allows configuration of the installed Python and add-ons to use.
For the GeoProcessor, this means that a script is use to run the GeoProcssor,
and a separate script is used to start PyCharm so that it can run the GeoProcessor (discussed in following sections).

In addition to a standard system or user Python installation, Python now also supports a virtual environment approach.
This approach is used to fully isolate the Python installation used by an application.
More disk space is needed because multiple versions of Python are installed in various folders.
However, the application is fully isolated from changes to the system/user Python installations.
A virtual environment approach is used with PyCharm development (see [Development Environment / PyCharm section](pycharm.md)) to run PyCharm.
A virtual environment approach is also used to deploy the GeoProcessor
(see [Development Tasks / Creating Installer](../dev-tasks/creating-installer.md)).

* See [Pipenv and Virtual Environments](http://docs.python-guide.org/en/latest/dev/virtualenvs/).

The MkDocs software, which is used to prepare documentation,
will generally use a system/user version of Python since it can be used across multiple
Python projects.
The Python version that is used will be updated to include the MkDocs software packages and launch program.
In other words, the Python that is used for MkDocs may not be the QGIS or PyCharm Python versions.

The following can be used to check the version of Python that is installed:

#### ![Cygwin](../images/cygwin-32.png) Cygwin ####

```sh
$ which python3
$ python3 --version
```

#### ![Linux](../images/linux-32.png) Linux ####

```sh
$ which python3
$ python3 --version
```

#### ![Windows](../images/windows-32.png) Windows ####

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
a system folder that is always in the `PATH`:

```
> where py
C:\Windows\py.exe
```

The `py` program provides a unified interface to Python and automatically finds Python installed in standard locations.
Use `py --help` to see usage information.
To be certain about which Python is being run, use an option like `py -3.7`,
where the number agrees with the QGIS Python version for consistency.
Windows batch files that run Python in the development environment use `py` with appropriate command line options
and the deployed software uses scripts that find the QGIS Python (for `gp` variant of GeoProcessor) and
virtual environment (for `gptest` variant).

#### ![Cygwin](../images/cygwin-32.png) Cygwin ####

Use the Cygwin setup tool to install Python as part of the Cygwin setup.
See the [Cygwin Installation](cygwin.md) documentation.
The version should be as near as possible to that used by QGIS although the Cygwin setup tool will
only provide selections for `python3`, not a specific version.
The latest Cygwin Python 3 version is typically compatible with GeoProcessor.

#### ![Linux](../images/linux-32.png) Linux ####

Use the `apt-get` program to install the Python 3 that is supported on the system.
If may be necessary to do a custom install if Python 3.7 is not available for the operating system.
The version should be as near as possible to that used by QGIS.
The latest Cygwin Python 3 version is typically compatible with GeoProcessor and version 3.4
and later has been tested successfully.

#### ![Windows](../images/windows-32.png) Windows ####

Download and install Python for Windows.
The version should be as near as possible to that used by QGIS, for example 3.7 in both cases.
If necessary, install QGIS first to confirm the Python version that is used.  See:

* [GeoProcessor Development Environment / QGIS](qgis.md)
* [Python Releases for Windows](https://www.python.org/downloads/windows/)
* [OWF / Learn Python](http://learn.openwaterfoundation.org/owf-learn-python/dev-env/python/python/)

## Install Additional Python Packages ##

After installing Python it will be necessary to install additional Python packages
that enable necessary functionality in the development environment,
such a as creating virtual environments.

### Packages Needed for the Development Environment ###

These packages are needed to support the development environment.

#### ![Cygwin](../images/cygwin-32.png) Cygwin ####

For Cygwin GeoProcessor `gptest` testing framework,
the GeoProcessor is run in a virtual environment into which are installed necessary Python additional packages.
Cygwin is often also typically used to run MkDocs for documentation.
Therefore, install the following Python packages in the Cygwin system Python,
from a Cygwin terminal window:

| **Package**           | **Description**                  | **Installation Command**       |
| --------------------- | -------------------------------- | ------------------------------ |
| `mkdocs`              | MkDocs documentation software.   | `pip3 install mkdocs`          |
| `mkdocs-material`     | MkDocs material theme.           | `pip3 install mkdocs-material` |
| `virtualenv`          | Python virtual environment tool. | `pip3 install virtualenv`      |

#### ![Linux](../images/linux-32.png) Linux ####

For Linux GeoProcessor `gptest` testing framework,
the GeoProcessor is run in a virtual environment into which are installed necessary Python additional packages.
MkDocs may be used for documentation (or such documentation editing may be confined to Windows/Cygwin).
Therefore, install the following Python packages in the Linux system Python from a Linux terminal window:

| **Package**           | **Description**                  | **Installation Command**       |
| --------------------- | -------------------------------- | ------------------------------ |
| `mkdocs`              | MkDocs documentation software.   | `pip3 install mkdocs`          |
| `mkdocs-material`     | MkDocs material theme.           | `pip3 install mkdocs-material` |
| `virtualenv`          | Python virtual environment tool. | `pip3 install virtualenv`      |

#### ![Windows](../images/windows-32.png) Windows QGIS Development Environment ####

The Windows QGIS development environment requires a number of additional packages
that are used by the GeoProcessor and if not installed will result in import errors when running the GeoProcessor.
The packages are installed into the QGIS Python environment.
See the [QGIS Install Additional Python Packages documentation](qgis.md#install-additional-python-packages) for instructions.
In particular, make sure to install `virtualenv` in order to be able to create Windows GeoProcessor
Python virtual environments for testing and for the GeoProcessor installer.

For general Python version (non-QGIS version) and to create the GeoProcessor virtual environment,
install the following additional packages in a Windows command shell for the developer's Python (non-QGIS Python).
Note that MkDocs is generally run in Cygwin but some developers may want to run in Windows.
**Currently a `gptest` (non-QGIS) version of the GeoProcessor and the `gp` distribution packages
a Python virtual environment that is not used (yet).**

The installation commands below indicate to the general Windows `py.exe` program which specific Python version
to install, by running `pip` within the correct Python version. 

| **Package**           | **Description**                  | **Installation Command**       |
| --------------------- | -------------------------------- | ------------------------------ |
| `mkdocs`              | MkDocs documentation software.   | `py -3.7 -m pip install mkdocs`          |
| `mkdocs-material`     | MkDocs material theme.           | `py -3.7 -m pip install mkdocs-material` |
| `virtualenv`          | Python virtual environment tool. | `py -3.7 -m pip install virtualenv`      |

### Packages Needed by GeoProcessor ###

The GeoProcessor uses some third-party Python packages that need to be installed using standard `pip` approach,
described for Windows 10.

#### Install in Python Virtual Environment ####

Third party packages should be installed in a Python virtual environment (venv) as follows.
For example, use this approach to install software in venv used by Python.

1. In a Windows command prompt, change folders to the `venv/venv-qgis-3.10-python37\Scripts` folder.
2. Activate the venv by running `activate.bat`.
3. Install the packages listed in the following table.

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

This is because the venv Python does not include SSL.  Test on a Python installed on the system:

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

And, on the GeoProcessor PyCharm project venv Python:

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
Following this advice, copy from a personal Python 3.7 `AppData/Local/Programs/Python/Python7/` the files 
`libcripto-1_1-x64.dll` and `libssl_1_1-64.dll` to the venv `Scripts` folder.
Then get the following, indicating that `SSL` is loading:

```
(venv-qgis-3.10-python37) C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python\venv\venv-qgis-3.10-python37\Scripts>python
Python 3.7.0 (v3.7.0:1bf9cc5093, Jun 27 2018, 04:59:51) [MSC v.1914 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import ssl
>>> quit()
```

Then, install according to the table below.  After installing, the PyCharm ***Settings / Project / Project Interpreter*** package list will display the newly installed packages.

**<p style="text-align: center;">
Additional Python Packages for Virtual Environment
</p>**

|**Software Package Name**|**Source Link(s)**|**How Used Within GeoProcessor**| **Command**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|
|-|-|-|-|
|pandas|[https://pandas.pydata.org/](https://pandas.pydata.org/)|Holds and manipulates Table data.<br>**May already be installed in QGIS Python - check Project Interpreter package list in Pycharm File / Settings.**|`python -m pip install pandas`|
|OpenPyXL|[https://openpyxl.readthedocs.io/en/stable/](https://openpyxl.readthedocs.io/en/stable/)|Reads and writes Excel 2010 xlsx/xlsm files to and from Table objects.<br>**Does not seem to be installed with QGIS Python.** |`python -m pip install openpyxl`|
|requests (extended package)|[http://docs.python-requests.org/en/master/](http://docs.python-requests.org/en/master/)<br><br> [https://pypi.org/project/requests/](https://pypi.org/project/requests/)|Downloads data files within the [`WebGet`](http://learn.openwaterfoundation.org/owf-app-geoprocessor-python-doc-user/command-ref/WebGet/WebGet/) command. <br><br>The `requests[security]` extension package is preferred over the core `requests` package to avoid an error that would occur when downloading a file over `https` with the [`WebGet`](http://learn.openwaterfoundation.org/owf-app-geoprocessor-python-doc-user/command-ref/WebGet/WebGet/) command. The error that occurred when using the core `requests` package printed:<br>`requests.exceptions.SSLError: [Errno 1] _ssl.c:503: error:140770FC:SSL routines:SSL23_GET_SERVER_HELLO:unknown protocol`. <br>This error does not occur when utilizing the `requests[security]` extension package.<br>**The `requests` package is installed with QGIS Python but not `requests[security]`, so install it.** | `python -m pip install requests[security]`|
|SQLAlchemy|[http://www.sqlalchemy.org/](http://www.sqlalchemy.org/)|Enables connections to databases.<br>**Does not seem to be installed in QGIS Python.**|`python -m pip install SQLAlchemy`|
|virtualenv|[https://virtualenv.pypa.io/en/latest/](https://virtualenv.pypa.io/en/latest/)|Used to package the GeoProcessor runtime into an isolated Python environment when [creating an installer](../dev-tasks/creating-installer.md).<br>**Does not seem to be installed in QGIS Python - is this why sometimes creating venv in Python does not work the first time?.**|`python -m pip install virtualenv`|

#### Install in QGIS Python ####

**This documentation is old and needs to be reviewed and updated.
It is kept as a reminder.**

The GeoProcessor uses some third-party packages.
Previously, the development environment installed these packages in the QGIS Python.
However, this approach is no longer taken in order to ensure that a user's QGIS environment
is not changed unexpectedly by the GeoProcessor installation.
Rather, the packages are installed in the development venv,
which results in the packages being installed in `Lib/site-packages`.

1. Open ***Start / QGIS 3.10 / OSGeo4W Shell*** (for standalone QGIS install) or
***Start / OSGeo4W / OSGeo4W Shell*** (for OSGeo4W QGIS insall) to start an environment compatible with QGIS Python.
Note that by default (as of 2019-01-20) the initial configuration will use Python 27
This seems like something that will be remedied in the future, in which case the following instructions
may need to be modified.
See the article [OSGeo4W shell with python3](https://gis.stackexchange.com/questions/273870/osgeo4w-shell-with-python3).
Therefore, once the shell is open, run `C:\OSGeo4W64\bin\py3_env.bat`.
3. Enter the command to install the software package.
Note that `python3 -m pip` is used instead of `pip3` because `pip3` is not available in the QGIS bin folder.

**<p style="text-align: center;">
Additional Python Packages for QGIS
</p>**

|**Software Package Name**|**Source Link(s)**|**How Used Within GeoProcessor**| **Command**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|
|-|-|-|-|
|pandas|[https://pandas.pydata.org/](https://pandas.pydata.org/)|Holds and manipulates Table data.|`python3 -m pip install pandas`|
|OpenPyXL|[https://openpyxl.readthedocs.io/en/stable/](https://openpyxl.readthedocs.io/en/stable/)|Reads and writes Excel 2010 xlsx/xlsm files to and from Table objects.|`python3 -m pip install openpyxl`|
|requests (extended package)|[http://docs.python-requests.org/en/master/](http://docs.python-requests.org/en/master/)<br><br> [https://pypi.org/project/requests/](https://pypi.org/project/requests/)|Downloads data files within the [`WebGet`](http://learn.openwaterfoundation.org/owf-app-geoprocessor-python-doc-user/command-ref/WebGet/WebGet/) command. <br><br>The `requests[security]` extension package is preferred over the core `requests` package to avoid an error that would occur when downloading a file over `https` with the [`WebGet`](http://learn.openwaterfoundation.org/owf-app-geoprocessor-python-doc-user/command-ref/WebGet/WebGet/) command. The error that occurred when using the core `requests` package printed:<br>`requests.exceptions.SSLError: [Errno 1] _ssl.c:503: error:140770FC:SSL routines:SSL23_GET_SERVER_HELLO:unknown protocol`. <br>This error does not occur when utilizing the `requests[security]` extension package. | `python3 -m pip install requests[security]`|
|SQLAlchemy|[http://www.sqlalchemy.org/](http://www.sqlalchemy.org/)|Enables connections to databases.|`python3 -m pip install SQLAlchemy`|
|virtualenv|[https://virtualenv.pypa.io/en/latest/](https://virtualenv.pypa.io/en/latest/)|Used to package the GeoProcessor runtime into an isolated Python environment when [creating an installer](../dev-tasks/creating-installer.md).  **This only needs to be installed if the software developer will be building the Windows GeoProcessor installer using this Python.**|`python3 -m pip install virtualenv`|
