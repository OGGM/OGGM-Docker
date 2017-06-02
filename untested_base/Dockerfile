###################################################
# Dockerfile to build a Python 3.5 environment
# with OGGM installed, based on Ubuntu 16.04.
###################################################

FROM ubuntu:16.04
MAINTAINER Timo Rothenpieler

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y install \
	gfortran \
	ttf-bitstream-vera \
	git \
	build-essential \
	liblapack-dev \
	libproj-dev \
	libfreetype6-dev \
	gdal-bin \
	libgdal-dev \
	libagg-dev \
	netcdf-bin \
	python3-netcdf4 \
	python3-dev \
	python3-numpy-dev \
	python3-pip \
	awscli \
	locales && \
	apt-get clean

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN \
	pip3 install --no-cache-dir --upgrade pip setuptools

RUN \
	pip3 install --no-cache-dir --upgrade numpy && \
	pip3 install --no-cache-dir --upgrade scipy && \
	pip3 install --no-cache-dir --upgrade pandas shapely cython && \
	pip3 install --no-cache-dir --upgrade matplotlib

RUN \
	pip3 install --no-cache-dir --upgrade gdal==1.11.2 --install-option="build_ext" --install-option="--include-dirs=/usr/include/gdal"

RUN \
	pip3 install --no-cache-dir --upgrade fiona --install-option="build_ext" --install-option="--include-dirs=/usr/include/gdal"

RUN \
	pip3 install --no-cache-dir --upgrade pyproj rasterio Pillow geopandas netcdf4 scikit-image configobj joblib xarray cartopy nose filelock pytest pytest-mpl pytest-cov progressbar2 boto3

RUN \
	pip3 install --no-cache-dir --upgrade git+https://github.com/ryancox/motionless.git@6a2a4c93be2cb44a7ce505e39df642e3ef5dc0e0 && \
	pip3 install --no-cache-dir --upgrade git+https://github.com/fmaussion/salem.git@0512264f627d770dd5d329d88b17a10c05aa0095 && \
	pip3 install --no-cache-dir --upgrade git+https://github.com/fmaussion/cleo.git@8d20651eb6fd13713dbca6e4008d21dc1175c1fe

RUN sed -i 's/^backend.*/backend : Agg/' /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/matplotlibrc

ADD test.sh /root/test.sh

RUN python3 -c "import matplotlib.font_manager"
