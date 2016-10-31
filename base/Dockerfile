###################################################
# Dockerfile to build a Python 3.5 environment
# with OGGM installed, based on Ubuntu 16.04.
###################################################

FROM ubuntu:16.04
MAINTAINER Timo Rothenpieler

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

ADD test.sh /root/test.sh

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
	awscli && \
	apt-get clean

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
	pip3 install --no-cache-dir --upgrade pyproj rasterio Pillow geopandas netcdf4 scikit-image configobj joblib xarray cartopy nose filelock progressbar2==3.9.4

RUN \
	pip3 install --no-cache-dir --upgrade git+https://github.com/fmaussion/motionless.git@f281dc46d7c33159c36fbb98f6b62caf06184b35 && \
	pip3 install --no-cache-dir --upgrade git+https://github.com/fmaussion/salem.git@01d993839239422b04de04225dd95d1c57af8acd && \
	pip3 install --no-cache-dir --upgrade git+https://github.com/fmaussion/cleo.git@8d20651eb6fd13713dbca6e4008d21dc1175c1fe

RUN sed -i 's/^backend.*/backend : Agg/' /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/matplotlibrc

RUN python3 -c "import matplotlib.font_manager"
