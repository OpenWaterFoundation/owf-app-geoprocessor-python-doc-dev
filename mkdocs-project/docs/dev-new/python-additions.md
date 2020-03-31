**This section has been tested with OSGeo4W QGIS installation but not standalone QGIS installation.**

After installing QGIS, it is necessary to install additional Python packages that are used in the GeoProcessor.
Currently, these are installed in the QGIS Python environment.
However, in the future an alternate approach may be implemented to avoid dependency conflicts in the QGIS environment
(should that case occur).
The deployed GeoProcessor environment uses a virtual environment that keeps QGIS files separate from 
GeoProcessor-related Python packages.
To install the third party packages in the QGIS installation, run the installation commands as shown in the following table.

To install third party packages on the Windows QGIS version of GeoProcessor:

1. Open ***Start / OSGeo4W / OSGeo4W Shell*** to start an environment compatible with OSGeo4W Python.
Note that by default (as of 2019-01-20) the initial configuration will use Python 27
This seems like something that will be remedied in the future, in which case the following instructions
may need to be modified.
See the article [OSGeo4W shell with python3](https://gis.stackexchange.com/questions/273870/osgeo4w-shell-with-python3).
Therefore, once the shell is open, run `C:\OSGeo4W64\bin\py3_env.bat`.
3. Enter the command to install the software package.
Note that `python3 -m pip` is used instead of `pip3` because `pip3` is not available in the QGIS bin folder.

|**Software Package Name**|**Source Link(s)**|**How Used Within GeoProcessor**| **Command**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|
|-|-|-|-|
|pandas|[https://pandas.pydata.org/](https://pandas.pydata.org/)|Holds and manipulates Table data.|`python3 -m pip install pandas`|
|OpenPyXL|[https://openpyxl.readthedocs.io/en/stable/](https://openpyxl.readthedocs.io/en/stable/)|Reads and writes Excel 2010 xlsx/xlsm files to and from Table objects.|`python3 -m pip install openpyxl`|
|requests (extended package)|[http://docs.python-requests.org/en/master/](http://docs.python-requests.org/en/master/)<br><br> [https://pypi.org/project/requests/](https://pypi.org/project/requests/)|Downloads data files within the [`WebGet`](http://learn.openwaterfoundation.org/owf-app-geoprocessor-python-doc-user/command-ref/WebGet/WebGet/) command. <br><br>The `requests[security]` extension package is preferred over the core `requests` package to avoid an error that would occur when downloading a file over `https` with the [`WebGet`](http://learn.openwaterfoundation.org/owf-app-geoprocessor-python-doc-user/command-ref/WebGet/WebGet/) command. The error that occurred when using the core `requests` package printed:<br>`requests.exceptions.SSLError: [Errno 1] _ssl.c:503: error:140770FC:SSL routines:SSL23_GET_SERVER_HELLO:unknown protocol`. <br>This error does not occur when utilizing the `requests[security]` extension package. | `python3 -m pip install requests[security]`|
|SQLAlchemy|[http://www.sqlalchemy.org/](http://www.sqlalchemy.org/)|Enables connections to databases.|`python3 -m pip install SQLAlchemy`|
|virtualenv|[https://virtualenv.pypa.io/en/latest/](https://virtualenv.pypa.io/en/latest/)|Used to package the GeoProcessor runtime into an isolated Python environment when [creating an installer](../dev-tasks/creating-installer.md).  **This only needs to be installed if the software developer will be building the Windows GeoProcessor installer.**|`python3 -m pip install virtualenv`|

