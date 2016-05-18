###################################################
# Dockerfile to build a Python 2.7 environment
# with OGGM installed, based on Ubuntu 16.04.
###################################################

FROM ubuntu:16.04
MAINTAINER Timo Rothenpieler

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get -y update && apt-get -y install \
	gfortran \
	python-netcdf4 \
	python-tk \
	python-dev \
	python-pip \
	python-setuptools \
	python-numpy \
	python-scipy \
	python-pandas \
	python-shapely \
	python-matplotlib \
	python-gdal \
	python-fiona \
	python-pyproj \
	python-rasterio \
	python-pil \
	python-geopandas \
	python-skimage \
	python-skimage-lib \
	python-configobj \
	python-joblib \
	python-nose \
	python-descartes \
	cython \
	ttf-bitstream-vera \
	git \
	awscli && \
	apt-get clean

RUN sed -i 's/^backend.*/backend : Agg/' /etc/matplotlibrc

RUN \
	pip install xarray progressbar2 && \
	pip install git+https://github.com/fmaussion/motionless.git@f281dc46d7c33159c36fbb98f6b62caf06184b35 && \
	pip install git+https://github.com/fmaussion/salem.git@123750ba9fc46286f7809076e71d349ef03d85b5 && \
	pip install git+https://github.com/fmaussion/cleo.git@a2488bd61f91ffc4ddda17605c7f41e9f153f863

RUN \
	pip install git+https://github.com/OGGM/oggm.git@796e783368497dc281d3643664a75b4cbaa71236

