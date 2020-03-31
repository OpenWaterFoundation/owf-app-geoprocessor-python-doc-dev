# GeoProcessor / Development Environment / MkDocs #

MkDocs must be installed in order to develop the user and developer documentation.

* See the [MkDocs website](https://www.mkdocs.org/)
* See the [OWF / Learn MkDocs / Install MkDocs](http://learn.openwaterfoundation.org/owf-learn-mkdocs/install/) documentation.

The QGIS Python is used for PyCharm and running GeoProcessor in the development and operational environments.
However, MkDocs does not need to run using a consistent Python.
It just needs a version of of Python that is compatible with the version of MkDocs that is being used.

MkDocs 1.x and Python 3 are used for GeoProcessor documentation.
The `build-util/run-mkdocs-serve-8000.sh` script in the user documentation repository and
`build-util/run-mkdocs-serve-8001.sh` script in the developer documentation
repository are used to run MkDocs server for documentation editing.
