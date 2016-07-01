###################################################
# Dockerfile to build a Python 3.5 environment
# with OGGM installed, based on Ubuntu 16.04.
###################################################

FROM ubuntu:16.04
MAINTAINER Timo Rothenpieler

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get -y update && apt-get -y install \
	gfortran \
	python3-netcdf4 \
	python3-tk \
	python3-dev \
	python3-pip \
	python3-setuptools \
	python3-numpy \
	python3-scipy \
	python3-pandas \
	python3-shapely \
	python3-matplotlib \
	python3-gdal \
	python3-fiona \
	python3-pyproj \
	python3-rasterio \
	python3-pil \
	python3-geopandas \
	python3-skimage \
	python3-skimage-lib \
	python3-configobj \
	python3-joblib \
	python3-nose \
	python3-descartes \
	cython3 \
	ttf-bitstream-vera \
	git \
	awscli && \
	apt-get clean

RUN sed -i 's/^backend.*/backend : Agg/' /etc/matplotlibrc

RUN \
	pip3 install xarray progressbar2 && \
	pip3 install git+https://github.com/fmaussion/motionless.git@f281dc46d7c33159c36fbb98f6b62caf06184b35 && \
	pip3 install git+https://github.com/fmaussion/salem.git@107c41244582e772778fd4f4ae1519769a3456ee && \
	pip3 install git+https://github.com/fmaussion/cleo.git@a2488bd61f91ffc4ddda17605c7f41e9f153f863
