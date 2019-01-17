###################################################
# Dockerfile to build a Python 3.7 environment
# based on Ubuntu 18.04.
###################################################

FROM ubuntu:18.04
MAINTAINER Timo Rothenpieler

ENV DEBIAN_FRONTEND noninteractive

RUN \
	apt-get -y update && \
	apt-get -y install \
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

RUN \
	mkdir /tmp/buildpy37 && cd /tmp/buildpy37 && \
	curl https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tar.xz -o Python-3.7.2.tar.xz && \
	tar xaf Python-3.7.2.tar.xz && cd Python-3.7.2 && \
	./configure --prefix=/usr --with-ensurepip=upgrade --enable-shared && \
	make -j4 && make altinstall && \
	cd - && rm -rf /tmp/* /var/tmp/*

ENV PIP pip3.7

RUN rm -f /usr/bin/pip /usr/bin/python3 /usr/bin/python3m && ln -s python3.7 /usr/bin/python3 && ln -s python3.7m /usr/bin/python3m && ln -s pip3.7 /usr/bin/pip

RUN $PIP install --no-cache-dir --upgrade pip setuptools
