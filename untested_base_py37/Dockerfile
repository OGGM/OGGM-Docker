###################################################
# Dockerfile to build a Python 3.7 environment
# with OGGM installed, based on Ubuntu 19.04.
###################################################

FROM oggm/raw_system:py37 as builder

RUN \
	$PIP install --no-cache-dir --upgrade "gdal<$(gdal-config --version | cut -d. -f1).$(( $(gdal-config --version | cut -d. -f2) + 1 ))" --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

RUN \
	$PIP install --no-cache-dir --upgrade fiona --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

# Packages to install from binary wheels:
# Remove urllib3 limit whenever aws/botocore fixes its stuff.
RUN \
	$PIP install --no-cache-dir --upgrade \
		"pyproj<2"

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
		xarray \
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


FROM ubuntu:19.04

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
