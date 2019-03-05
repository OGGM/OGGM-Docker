###################################################
# Dockerfile to build a Python 3.7 environment
# with OGGM installed, based on Ubuntu 18.04.
###################################################

FROM oggm/raw_system:py37
MAINTAINER Timo Rothenpieler

RUN \
	$PIP install --no-cache-dir --upgrade "gdal<$(gdal-config --version | cut -d. -f1).$(( $(gdal-config --version | cut -d. -f2) + 1 ))" --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

RUN \
	$PIP install --no-cache-dir --upgrade fiona --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

# Revert from installing geopandas(0.4.0) from git with their next respective release!
RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: \
		pyproj \
		"rasterio>=1.0.0" \
		descartes \
		Pillow \
		"git+https://github.com/geopandas/geopandas.git@0.4.x" \
		netcdf4 \
		scikit-image \
		configobj \
		joblib \
		xarray \
		cartopy \
		nose \
		filelock \
		pytest \
		pytest-cov \
		"git+https://github.com/OGGM/pytest-mpl.git" \
		ilock \
		progressbar2 \
		boto3 \
		motionless \
		versioneer \
		requests \
		tifffile \
		"git+https://github.com/fmaussion/salem.git"

RUN \
	sed -i 's/^backend.*/backend : Agg/' /usr/lib/python3.7/site-packages/matplotlib/mpl-data/matplotlibrc

RUN python3 -c "import matplotlib.font_manager, salem"

RUN mkdir /work

ADD test.sh /root/test.sh
