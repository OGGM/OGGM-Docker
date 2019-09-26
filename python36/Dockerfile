###################################################
# Dockerfile to build a Python 3.6 environment
# based on Ubuntu 18.04.
###################################################

FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN \
	apt-get -y update && \
	apt-get -y install \
		gfortran \
		fontconfig \
		fonts-dejavu \
		git \
		build-essential \
		liblapack-dev \
		libfreetype6-dev \
		gdal-bin \
		libgdal-dev \
		libagg-dev \
		liblapack-dev \
		netcdf-bin \
		libnetcdf-dev \
		libssl-dev \
		libffi-dev \
		blt-dev \
		libdb-dev \
		libreadline-dev \
		libncursesw5-dev \
		zlib1g-dev \
		libbz2-dev \
		liblzma-dev \
		libsqlite3-dev \
		libgdbm-dev \
		libmpdec-dev \
		libexpat1-dev \
		curl \
		locales && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

ENV PYENV_ROOT /usr/local/pyenv
RUN \
	git clone --depth=1 https://github.com/pyenv/pyenv.git $PYENV_ROOT && \
	rm -rf $PYENV_ROOT/.git
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN \
	DO_PYVER=3.6.9 && \
	pyenv install $DO_PYVER && \
	pyenv global $DO_PYVER && \
	pyenv rehash

ENV PIP pip

RUN \
	$PIP install --no-cache-dir --upgrade pip setuptools wheel virtualenv

RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: numpy && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: cython six && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: scipy && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: pandas shapely && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: "matplotlib>=3.0.0,!=3.1.0*,!=3.1.0,!=3.1.1"
