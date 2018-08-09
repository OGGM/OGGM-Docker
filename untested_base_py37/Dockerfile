###################################################
# Dockerfile to build a Python 3.6 environment
# with OGGM installed, based on Ubuntu 18.04.
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
	curl https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz -o Python-3.7.0.tar.xz && \
	tar xaf Python-3.7.0.tar.xz && cd Python-3.7.0 && \
	./configure --prefix=/usr --with-ensurepip=upgrade --enable-shared && \
	make -j4 && make altinstall && \
	cd - && rm -rf /tmp/* /var/tmp/*

ENV PIP pip3.7

RUN \
	$PIP install --no-cache-dir --upgrade pip setuptools

RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: cython && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: numpy && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: scipy && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: pandas shapely

RUN \
	$PIP install --no-cache-dir --no-binary :all: --upgrade matplotlib

RUN \
	$PIP install --no-cache-dir --upgrade "gdal==$(gdal-config --version)" --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

RUN \
	$PIP install --no-cache-dir --upgrade fiona --install-option="build_ext" --install-option="--include-dirs=/usr/include/gdal"

RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: "git+https://github.com/jswhit/pyproj.git" "git+https://github.com/mapbox/rasterio@0.36.0" descartes Pillow geopandas netcdf4 scikit-image configobj joblib xarray cartopy nose filelock pytest pytest-mpl pytest-cov ilock progressbar2 boto3 motionless versioneer requests

RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: git+https://github.com/fmaussion/salem.git@ce6482bb0125f3236078ddd29946126f278cf686

RUN \
	sed -i 's/^backend.*/backend : Agg/' /usr/lib/python3.7/site-packages/matplotlib/mpl-data/matplotlibrc && \
	rm -f /usr/bin/python3 /usr/bin/python3m && ln -s python3.7 /usr/bin/python3 && ln -s python3.7m /usr/bin/python3m

RUN python3.7 -c "import matplotlib.font_manager, salem"

ADD test.sh /root/test.sh
