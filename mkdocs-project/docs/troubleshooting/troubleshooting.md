# GeoProcessor / Troubleshooting #

The GeoProcessor is a Python application that uses Python modules that are a part of the GeoProcessor,
and Python modules and software that are part of the QGIS (PyQGIS) and Qt (PyQt) software.
Consequently, errors can occur in various software components.
This page provides information about troubleshooting the GeoProcessor.

* [Logging](#logging)
	+ [Log File](#log-file)
	+ [Command Status/Log](#command-statuslog)
* [GeoProcessor Runtime Error Messages](#geoprocessor-runtime-error-messages)

-------------

## Logging ##

The GeoProcessor uses the Python `logging` package to log messages to a log file.
Additionally, each command has a log that is used to display command-specific messages.
The following sections describe logging.

### Log File ###

The GeoProcessor uses the Python logging features to create a log file that is helpful to troubleshoot issues.
However, although log files may be helpful to software developers, they can be difficult for others to understand.
The log file exists in the following locations:

* User's home folder GeoProcessor files, for example as follows, where `1` is the GeoProcessor major version and `user` is the user:
	+ Windows: `C:\Users\user\.owf-gp\1\logs\gp_user.log`
	+ Linux:  `/home/user/.owf-gp/1/logs/gp_user.log`
	+ Cygwin:  `/cygdrive/C/Users/user/.owf-gp/1/logs/gp_user.log` (different files from Windows)
	+ Git Bash (MinGW):  `/c/Users/user/.owf-gp/1/logs/gp_user.log` (same files as Windows)
* File specified by the GeoProcessor [StartLog](http://software.openwaterfoundation.org/geoprocessor/latest/doc-user/command-ref/StartLog/StartLog/) command.

The log file contains a sequential record of log messages for application startup followed by
output from running the commands, as shown in the following example.
The first part of the line indicates the message type, which can be one of the following,
shown in increasing severity and therefore decreasing frequency:  `DEBUG`, `INFO`, `WARNING`, `ERROR`, and `CRITICAL`.
In other words, one should expect very few `CRITICAL` messages.  Any message of level `WARNING`, `ERROR`, or `CRITICAL`
should be dealt with because they can lead to a proliferation of problems in later commands.

```txt
INFO|geoprocessor|log line 151|Opened new log file: "C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python-test\test\commands\RemoveFile\results\test-RemoveFile.gp.log"
INFO|geoprocessor.core.GeoProcessor|GeoProcessor line 547|-> Start processing command 2 of 5: # Test removing a file
INFO|geoprocessor.core.GeoProcessor|GeoProcessor line 547|-> Start processing command 3 of 5: # Uncomment the following line to regenerate expected results
INFO|geoprocessor.core.GeoProcessor|GeoProcessor line 547|-> Start processing command 4 of 5: CopyFile(SourceFile="data/testfile.txt",DestinationFile="results/test-RemoveFile-out.txt")
INFO|geoprocessor.commands.util.CopyFile|CopyFile line 144|Copying file "C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python-test\test\commands\RemoveFile\data\testfile.txt" to "C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python-test\test\commands\RemoveFile\results\test-RemoveFile-out.txt"
INFO|geoprocessor.core.GeoProcessor|GeoProcessor line 547|-> Start processing command 5 of 5: RemoveFile(SourceFile="results/test-RemoveFile-out.txt")
INFO|geoprocessor.commands.util.RemoveFile|RemoveFile line 120|Removing file "C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python-test\test\commands\RemoveFile\results\test-RemoveFile-out.txt"
INFO|geoprocessor|gp line 188|GeoProcessor properties after running:
INFO|geoprocessor|gp line 190|UserName = sam
INFO|geoprocessor|gp line 190|ComputerName = colorado
INFO|geoprocessor|gp line 190|InstallDirURL = None
INFO|geoprocessor|gp line 190|OutputStart = None
INFO|geoprocessor|gp line 190|InitialWorkingDir = C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python-test\test\commands\RemoveFile
INFO|geoprocessor|gp line 190|WorkingDir = C:\Users\sam\owf-dev\GeoProcessor\git-repos\owf-app-geoprocessor-python-test\test\commands\RemoveFile
INFO|geoprocessor|gp line 190|InputStart = None
INFO|geoprocessor|gp line 190|OutputEnd = None
INFO|geoprocessor|gp line 190|UserHomeDir = C:\Users\sam
INFO|geoprocessor|gp line 190|ProgramVersionString = None
INFO|geoprocessor|gp line 190|TempDir = c:\users\sam\appdata\local\temp
INFO|geoprocessor|gp line 190|ComputerTimezone = Mountain Standard Time
INFO|geoprocessor|gp line 190|InputEnd = None
INFO|geoprocessor|gp line 190|InstallDir = None
INFO|geoprocessor|gp line 190|OutputYearType = None
INFO|geoprocessor|gp line 190|UserHomeDirURL = file:///C:/Users/sam
INFO|geoprocessor|gp line 190|ProgramVersionNumber = None
```

### Command Status/Log ###

The GeoProcessor UI displays command-specific warning messages,
which indicate problems that need to be resolved.
A command flagged with red X or yellow warning symbol can be reviewed to determine problems
by right-clicking on a command and using the ***Show Command Status*** menu or mousing over the error/warning icon.

The current log file can be viewed using the ***Tools / View Log File*** menu.
The startup log file can be viewed using the ***Tools / View Startup Log File*** menu.

## GeoProcessor Runtime Error Messages ##

Error messages for GeoProcessor commands generally indicate how to fix issues,
such as correcting command parameters.
However, programming logic errors or other unforseen issues may result in
stack traces that are difficult to troubleshoot.
The following lists errors that have been encountered.

### Error Message: `ImportError: DLL load failed: The specified procedure could not be found.`

The following error may be shown and result in GeoProcessor not starting.
The cause has been shown to be a bad or incompatible DLL.
For example, manually copying DLLs so that `pip` can run and not have `SSL` issues caused this problem.
The solution is to remove the offending DLLs.

* See the [Development Environment / Python / Install Additional Python Packages / Troubleshooting](../dev-env/python.md#troubleshooting) documentation.

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
