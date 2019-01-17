###################################################
# Dockerfile to build a Python 3.7 environment
# with OGGM installed, based on Ubuntu 18.04.
###################################################

FROM oggm/raw_system:py37
MAINTAINER Timo Rothenpieler

RUN \
	echo "[build_ext]" >> $HOME/.pydistutils.cfg && \
	echo "force=1" >> $HOME/.pydistutils.cfg

RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: numpy && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: cython six && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: scipy && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: pandas shapely && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: matplotlib

RUN \
	$PIP install --no-cache-dir --upgrade "gdal==$(gdal-config --version)" --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

RUN \
	$PIP install --no-cache-dir --upgrade fiona --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

# At the current time, netcdf4(1.4.2) and scikit-image(0.14.1) do not support numpy-1.16 in any of their releases.
# Revert from installing them from git with their next respective release!
RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: \
		pyproj \
		"rasterio>=1.0.0" \
		descartes \
		Pillow \
		geopandas \
		"git+https://github.com/Unidata/netcdf4-python@master" \
		"git+https://github.com/scikit-image/scikit-image@v0.14.x" \
		configobj \
		joblib \
		xarray \
		cartopy \
		nose \
		filelock \
		pytest \
		pytest-cov \
		"git+https://github.com/OGGM/pytest-mpl" \
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
