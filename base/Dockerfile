###################################################
# Dockerfile to build a Python 3.6 environment
# with OGGM installed, based on Ubuntu 18.04.
###################################################

FROM ubuntu:18.04
MAINTAINER Timo Rothenpieler

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y install \
	gfortran \
	fontconfig \
	fonts-dejavu \
	git \
	build-essential \
	liblapack-dev \
	libproj-dev \
	libfreetype6-dev \
	gdal-bin \
	libgdal-dev \
	libagg-dev \
	liblapack-dev \
	netcdf-bin \
	libnetcdf-dev \
	python3-dev \
	python3 \
	python3-pip \
	locales && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV PIP pip3

RUN \
	$PIP install --no-cache-dir --upgrade pip setuptools

RUN \
	$PIP install --no-cache-dir --upgrade numpy && \
	$PIP install --no-cache-dir --upgrade scipy && \
	$PIP install --no-cache-dir --upgrade pandas shapely cython

RUN \
	$PIP install --no-cache-dir --no-binary matplotlib --upgrade matplotlib

RUN \
	$PIP install --no-cache-dir --upgrade "gdal==$(gdal-config --version)" --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

RUN \
	$PIP install --no-cache-dir --upgrade fiona --install-option="build_ext" --install-option="--include-dirs=/usr/include/gdal"

RUN \
	$PIP install --no-cache-dir --upgrade pyproj rasterio descartes Pillow geopandas netcdf4 scikit-image configobj joblib xarray cartopy nose filelock pytest pytest-mpl pytest-cov ilock progressbar2 boto3 motionless versioneer

RUN \
	$PIP install --no-cache-dir --upgrade git+https://github.com/fmaussion/salem.git@ce6482bb0125f3236078ddd29946126f278cf686

RUN \
	sed -i 's/^backend.*/backend : Agg/' /usr/local/lib/python3.6/dist-packages/matplotlib/mpl-data/matplotlibrc

RUN python3 -c "import matplotlib.font_manager, salem"

ADD test.sh /root/test.sh
