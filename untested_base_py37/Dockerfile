###################################################
# Dockerfile to build a Python 3.7 environment
# with OGGM installed, based on Ubuntu 19.10.
###################################################

FROM ubuntu:19.10 as builder

ARG DEBIAN_FRONTEND=noninteractive
ARG DO_PYVER=3.7.6

RUN \
	apt-get -y update && \
	apt-get -y install --no-install-recommends \
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
		libblosc-dev \
		curl \
		ca-certificates \
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
	pyenv install $DO_PYVER && \
	pyenv global $DO_PYVER && \
	pyenv rehash

ENV PIP pip

RUN $PIP install --no-cache-dir --upgrade pip setuptools wheel virtualenv

# Special-Case packages that have a specific build order and/or special parameters
# Revert to stable numpy once np.clip performance regressions are fixed.
RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: "numpy<1.17" && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: cython pybind11 six && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: scipy && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: pandas shapely && \
	$PIP install --no-cache-dir --upgrade --no-binary :all: "matplotlib>=3.1.2"
RUN \
	$PIP install --no-cache-dir --upgrade "gdal<$(gdal-config --version | cut -d. -f1).$(( $(gdal-config --version | cut -d. -f2) + 1 ))" --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')" && \
	$PIP install --no-cache-dir --upgrade fiona --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

# Packages to install from binary wheels:
RUN \
	$PIP install --no-cache-dir --upgrade \
		pyproj

# Packages to force local build:
RUN \
	$PIP install --no-cache-dir --upgrade --no-binary :all: \
		"rasterio>=1.0.0" \
		descartes \
		Pillow \
		geopandas \
		netCDF4 \
		scikit-image \
		configobj \
		joblib \
		dask \
		distributed \
		"xarray>=0.14.1" \
		cartopy \
		nose \
		filelock \
		pytest \
		pytest-cov \
		ilock \
		progressbar2 \
		motionless \
		versioneer \
		requests \
		tifffile \
		"git+https://github.com/OGGM/pytest-mpl.git" \
		"git+https://github.com/fmaussion/salem.git"

RUN \
	sed -i 's/^backend.*/backend : Agg/' "$(python3 -c "import matplotlib, os; print(os.path.dirname(matplotlib.__file__))")"/mpl-data/matplotlibrc


FROM ubuntu:19.10

ARG DEBIAN_FRONTEND=noninteractive

RUN \
	apt-get -y update && \
	apt-get -y install --no-install-recommends \
		fontconfig \
		fonts-dejavu \
		libfreetype6 \
		netcdf-bin \
		gdal-bin \
		liblapack3 \
		libagg2 \
		libdb5.3 \
		libexpat1 \
		libbz2-1.0 \
		liblzma5 \
		libblosc1 \
		curl \
		git \
		locales \
		less \
		nano \
		ca-certificates && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

COPY --from=builder /usr/local/pyenv /usr/local/pyenv
ENV PYENV_ROOT /usr/local/pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
ENV PIP pip

RUN python3 -c "import matplotlib.font_manager, salem"

RUN mkdir /work

ADD test.sh /root/test.sh
