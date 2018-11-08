###################################################
# Dockerfile to build a Python 3.6 environment
# with OGGM installed, based on Ubuntu 18.04.
###################################################

FROM oggm/raw_system:py37
MAINTAINER Timo Rothenpieler

RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: cython && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: numpy && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: scipy && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: pandas shapely

RUN \
	$PIP install --no-cache-dir --no-binary :all: --upgrade matplotlib

RUN \
	$PIP install --no-cache-dir --upgrade "gdal==$(gdal-config --version)" --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

RUN \
	$PIP install --no-cache-dir --upgrade fiona --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: "git+https://github.com/jswhit/pyproj.git" "rasterio>=1.0.0" descartes Pillow geopandas netcdf4 scikit-image configobj joblib xarray cartopy nose filelock pytest pytest-cov "git+https://github.com/OGGM/pytest-mpl" ilock progressbar2 boto3 motionless versioneer requests

RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: git+https://github.com/fmaussion/salem.git@c3a4ef0324ccab470799b590ea0725a3a0a5aa56

RUN \
	sed -i 's/^backend.*/backend : Agg/' /usr/lib/python3.7/site-packages/matplotlib/mpl-data/matplotlibrc

RUN python3.7 -c "import matplotlib.font_manager, salem"

RUN mkdir /work

ADD test.sh /root/test.sh
