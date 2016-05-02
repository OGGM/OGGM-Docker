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
	pip install git+https://github.com/fmaussion/salem.git@c157b24c5864f7bb6b4edabc5116d423eaa26562 && \
	pip install git+https://github.com/fmaussion/cleo.git@5822a3ce1242e2640ab72443fa891d7d825f7a84

RUN \
	pip install git+https://github.com/OGGM/oggm.git@aff1326777f3e8302f6b808f6db77c1f380bfe92

ENV OGGM_DOCKER_TEST_COMMAND exec python2 -c \'import nose, os, sys, oggm; os.chdir(os.path.dirname(os.path.abspath(oggm.__file__))); nose.main(argv=[\"--detailed-errors\", \"--exe\"])\'
