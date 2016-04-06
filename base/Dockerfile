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
	pip3 install xarray && \
	pip3 install git+https://github.com/fmaussion/motionless.git@f281dc46d7c33159c36fbb98f6b62caf06184b35 && \
	pip3 install git+https://github.com/fmaussion/salem.git@c157b24c5864f7bb6b4edabc5116d423eaa26562 && \
	pip3 install git+https://github.com/fmaussion/cleo.git@5822a3ce1242e2640ab72443fa891d7d825f7a84

RUN \
	pip3 install git+https://github.com/OGGM/oggm.git@7be3ae0910199588b4cb90f9c1f994e1280b2fd9

ENV OGGM_DOCKER_TEST_COMMAND exec python3 -c \'import nose, os, sys, oggm; os.chdir(os.path.dirname(os.path.abspath(oggm.__file__))); nose.main(argv=[\"--detailed-errors\", \"--exe\"])\'
