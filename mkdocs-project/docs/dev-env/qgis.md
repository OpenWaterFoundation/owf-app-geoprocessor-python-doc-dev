# GeoProcessor / Development Environment / QGIS #

The GeoProcessor is developed for QGIS 3.x or later, with consistency at the Python level.
For example, QGIS 3.10 uses Python 3.7 (on Windows, see `C:\Program Files\apps\Python37\`).
The Python version used with QGIS will be updated over time, and GeoProcessor will be updated accordingly.
The following resources explain how to install QGIS.
64-bit QGIS is recommended and is the focus of development.
See the [GeoProcessor / QGIS / Python Versions](../dev-new/dev-new.md#install-qgis) table for a software version compatibility information.


* [Install QGIS](#install-qgis)
* [Install Additional Python Packages](#install-additional-python-packages)
* [QGIS Configuration Scripts](#qgis-configuration-scripts)
* [QGIS Folder Structure](#qgis-folder-structure)
    + [QGIS Python Distribution](#qgis-python-distribution)
    + [QGIS Python Modules](#qgis-python-modules)
    + [QGIS Supporting Programs](#qgis-supporting-programs)

-------------

## Install QGIS ##

Multiple versions of standalone QGIS can be installed, including latest release and long term release.
Important naming conventions help development environment tools use the correct versions.

To install QGIS, follow instructions in the
[OWF / Learn QGIS](http://learn.openwaterfoundation.org/owf-learn-qgis/install-qgis/install-qgis/) documentation.

Additional installation steps, such as configuring the PyCharm virtual environment,
and installing additional Python packages, are discussed in other sections of the documentation.

## Install Additional Python Packages ##

After QGIS is installed, additional Python packages must be installed in order to create
virtual environments that are used to develop and run PyCharm and the GeoProcessor.

See the [Python / Install Additional Python Packages](python.md#install-additional-python-packages)
documentation.

## QGIS Configuration Scripts ##

This information is provided as background.

Several QGIS configuration batch files (Windows) or scripts (Linux) are critical when configuring an environment to use QGIS Python tools,
such as the GeoProcessor.
These scripts are called by GeoProcessor `build-util/run-pycharm-ce-for-qgis.bat`,
`scripts/gpdev` and `scripts/gp` scripts to configure development and operational environments.
The following table lists the configuration batch files and scripts.

**<p style="text-align: center;">
QGIS Environment Configuration Scripts
</p>**

| **Windows Batch File2i&nbsp;** | **Linux Script** | **Comments** |
| -- | -- | -- |
| `o4w_env.bat` | ? | Configures QGIS core environment variables. |
| `py3_nv.bat` | ? | Configures Python 3 environment variables including `PYTHONHOME`, which indicates the location of Python software. |
| `qt_env.bat` | ? | Configures Qt environment variables, for graphical user interface. |

## QGIS Folder Structure ##

This information is provided as background.

It is important to understand the QGIS folder structure in order to integrate with the development environment and other applications.
The following sections discuss important information.

### QGIS Python Distribution ###

The QGIS Python distribution version will vary depending on QGIS install type and version.
The location of Python distribution is needed to configure virtual environments and to run Python.
The following table summarizes Python distribution location information.

**<p style="text-align: center;">
QGIS Python Distribution Information (for Windows)
</p>**

| **QGIS Install Type** | **Python Distribution Folder**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | **Comments** |
| -- | -- | -- |
| OSGeo4W | `C:\OSGeo4W64\apps\Python37` | The `python.exe` executable is in the distribution folder and also in `C:\OSGeo4W64\bin`.  An older python version such as `Python27` may be included if the release includes long-term release archive. |
| Standalone | `C:\Program Files\QGIS 3.10\apps\Python37`| The `python.exe` executable is in the distribution folder and also in `C:\Program Files\QGIS 3.10\bin`. |

Note that for a full Python distribution as in the above table, the Python executable is located in the main
distribution folder, for example for Windows:

```
C:\Program Files\QGIS 3.10\apps\Python37\python.exe
```

However, for a Python virtual environment, the executable location is similar to:

```
C:\...\venv-folder\Scripts\python.exe
```

### QGIS Python Modules ###

The Python QGIS (PyQGIS) modules that are used by Python applications must be added to the `PYTHONPATH` environment variable.
The following table summarizes location information.

**<p style="text-align: center;">
QGIS Python Module Location
</p>**

| **QGIS Installer** | **Location**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | **Comments** |
| -- | -- | -- |
| Standalone Latest Release | `apps/qgis/python` | |
| Standalone Long Term Release | `apps/qgis-ltr/python` | The `apps/qgis/python` folder may also exist but is typically empty.  Configuration scripts should check for `qgis-ltr` before `gqis` to check for long term release. |

### QGIS Supporting Programs ###

The QGIS desktop software is supported by various other software tools.
On Windows, the `C:\Program Files\QGIS 3.10\apps\` (or similar) folder lists major components,
for example QGIS itself.
To facilitate use of programs, executable program files are copied to the `bin/` folder,
which can be added to the `PATH` environment variable.
