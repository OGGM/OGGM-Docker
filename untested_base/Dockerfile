###################################################
# Dockerfile to build a Python 3.6 environment
# with OGGM installed, based on Ubuntu 18.04.
###################################################

FROM oggm/raw_system:latest
MAINTAINER Timo Rothenpieler

RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: cython && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: numpy && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: scipy && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: pandas shapely

RUN \
	$PIP install --no-cache-dir --no-binary :all: --upgrade "git+https://github.com/matplotlib/matplotlib.git@v3.0.x"

RUN \
	$PIP install --no-cache-dir --upgrade "gdal==$(gdal-config --version)" --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

RUN \
	$PIP install --no-cache-dir --upgrade fiona --install-option="build_ext" --install-option="--include-dirs=/usr/include/gdal"

RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: "git+https://github.com/jswhit/pyproj.git" "git+https://github.com/mapbox/rasterio@0.36.0" descartes Pillow geopandas netcdf4 scikit-image configobj joblib xarray cartopy nose filelock pytest pytest-cov "git+https://github.com/OGGM/pytest-mpl" ilock progressbar2 boto3 motionless versioneer requests

RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: git+https://github.com/fmaussion/salem.git@6f5e707571cdcadac69ea3125dabf7dd2ffa8201

RUN \
	sed -i 's/^backend.*/backend : Agg/' /usr/local/lib/python3.6/dist-packages/matplotlib/mpl-data/matplotlibrc

RUN python3 -c "import matplotlib.font_manager, salem"

ADD test.sh /root/test.sh
