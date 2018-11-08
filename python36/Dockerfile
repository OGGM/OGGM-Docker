###################################################
# Dockerfile to build a Python 3.6 environment
# based on Ubuntu 18.04.
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
	python3-venv \
	locales && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV PIP pip3

RUN rm -f /usr/bin/pip && ln -s pip3 /usr/bin/pip

RUN \
	$PIP install --no-cache-dir --upgrade pip setuptools
