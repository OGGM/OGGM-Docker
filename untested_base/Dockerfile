###################################################
# Dockerfile to build a Python environment
# with OGGM installed, based on Ubuntu 21.10.
###################################################

FROM ubuntu:21.10 as builder

ARG PYTHON_VERSION=3
ARG PROJ_VERSION=8.2.0
ARG GDAL_VERSION=3.3.3

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get -y update && \
	apt-get -y install --no-install-recommends \
		gfortran \
		fontconfig \
		fonts-dejavu \
		git \
		file \
		build-essential \
		liblapack-dev \
		libfreetype6-dev \
		libagg-dev \
		liblapack-dev \
		netcdf-bin \
		libnetcdf-dev \
		libssl-dev \
		libffi-dev \
		libtiff-dev \
		libpng-dev \
		libhdf4-dev \
		libhdf5-dev \
		libqhull-dev \
		libxml2-dev \
		libgif-dev \
		libjpeg-dev \
		libopenjp2-7-dev \
		libwebp-dev \
		libjson-c-dev \
		libgeos-dev \
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
		libbrotli-dev \
		liblcms2-dev \
		libjxr-dev \
		liblz4-dev \
		libsnappy-dev \
		libzopfli-dev \
		llvm-11 \
		llvm-11-dev \
		sqlite3 \
		curl \
		ca-certificates \
		unzip \
		locales && \
	apt-get -y purge gnupg && \
	apt-get -y autoremove && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN \
	curl -L "https://github.com/OSGeo/PROJ/releases/download/${PROJ_VERSION}/proj-${PROJ_VERSION}.tar.gz" -o proj.tar.gz && \
	tar xavf proj.tar.gz && \
	rm proj.tar.gz && \
	cd "proj-${PROJ_VERSION}" && \
	./configure --prefix=/opt/proj --enable-shared --disable-static --with-pic && \
	make -j$(nproc) && make install && \
	cd .. && \
	rm -rf "proj-${PROJ_VERSION}" && \
	echo /opt/proj/lib > /etc/ld.so.conf.d/optproj.conf && \
	ldconfig
ENV PROJ_DIR=/opt/proj PROJ_LIB=/opt/proj/share/proj PROJ_NETWORK=ON PKG_CONFIG_PATH=/opt/proj/lib/pkgconfig
ENV PATH $PROJ_DIR/bin:$PATH

RUN \
	curl -L "https://github.com/OSGeo/gdal/releases/download/v${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz" -o gdal.tar.xz && \
	tar xavf gdal.tar.xz && \
	rm gdal.tar.xz && \
	cd "gdal-${GDAL_VERSION}" && \
	./configure --prefix=/opt/proj --enable-shared --disable-static --with-pic --enable-lto --with-rename-internal-libgeotiff-symbols=yes \
		--with-proj=/opt/proj \
		--with-pcraster=internal --with-geotiff=internal \
		--with-hdf5=yes --with-netcdf=yes --with-libtiff=yes --with-jpeg=yes --with-libz=yes --with-png=yes --with-gif=yes --with-geos=yes && \
	make -j$(nproc) && make install && \
	cd .. && \
	rm -rf "gdal-${GDAL_VERSION}"

ENV PYENV_ROOT /usr/local/pyenv
RUN \
	git clone --depth=1 https://github.com/pyenv/pyenv.git $PYENV_ROOT && \
	git clone --depth=1 https://github.com/momo-lab/xxenv-latest.git $PYENV_ROOT/plugins/xxenv-latest && \
	rm -rf $PYENV_ROOT/.git $PYENV_ROOT/plugins/xxenv-latest/.git
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN \
	pyenv latest install $PYTHON_VERSION && \
	pyenv latest global $PYTHON_VERSION && \
	pyenv rehash && \
	(test -f $PYENV_ROOT/versions/*/bin/python3 || ln -s python $(echo -n $PYENV_ROOT/versions/*)/bin/python3)

RUN \
	python -m pip install --no-cache-dir --upgrade pip "setuptools<60" wheel virtualenv && \
	pyenv rehash

ENV PIP pip

# Matplotlib for some reason wants to bundle an ancient version of freetype
# Create setup.cfg to stop it
RUN printf '[libs]\nsystem_freetype = True\n' > /tmp/mpl_setup.cfg
ENV MPLSETUPCFG /tmp/mpl_setup.cfg

# Special-Case packages that have a specific build order and/or special parameters
ENV LLVM_CONFIG llvm-config-11
RUN \
	$PIP install --no-cache-dir --no-binary :all: numba && \
	$PIP install --no-cache-dir --no-binary :all: numpy && \
	$PIP install --no-cache-dir --no-binary :all: cython pybind11 six && \
	$PIP install --no-cache-dir --no-binary :all: scipy && \
	$PIP install --no-cache-dir --no-binary :all: pandas shapely && \
	$PIP install --no-cache-dir --no-binary :all: "matplotlib>=3.1.2"
RUN \
	$PIP install --no-cache-dir "gdal<$(gdal-config --version | cut -d. -f1).$(( $(gdal-config --version | cut -d. -f2) + 1 ))" --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')" && \
	$PIP install --no-cache-dir fiona --install-option="build_ext" --install-option="$(gdal-config --cflags | sed 's/-I/--include-dirs=/')"

RUN \
	$PIP install --no-cache-dir --no-binary :all: \
		pyproj

RUN \
	$PIP install --no-cache-dir --no-binary :all: \
		"rasterio >=1.0.0, !=1.2.8, !=1.2.7" \
		descartes \
		Pillow \
		geopandas \
		netCDF4 \
		"git+https://github.com/PyTables/PyTables.git" \
		scikit-image \
		configobj \
		joblib \
		dask \
		distributed \
		"xarray>=0.19.0" \
		"cartopy>=0.20.0" \
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
		Bottleneck \
		"git+https://github.com/OGGM/pytest-mpl.git" \
		"git+https://github.com/fmaussion/salem.git"

RUN \
	sed -i 's/^backend.*/backend : Agg/' "$(python3 -c "import matplotlib, os; print(os.path.dirname(matplotlib.__file__))")"/mpl-data/matplotlibrc && \
	pyenv rehash


FROM ubuntu:21.10

COPY --from=builder /opt/proj /opt/proj
COPY --from=builder /usr/local/pyenv /usr/local/pyenv

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get -y update && \
	apt-get -y install --no-install-recommends \
		fontconfig \
		fonts-dejavu \
		libfreetype6 \
		netcdf-bin \
		libtiff5 \
		libpng16-16 \
		libhdf4-0 \
		libhdf5-103 \
		libqhull8.0 \
		libqhull-r8.0 \
		libxml2 \
		libgif7 \
		libjpeg8 \
		libjpeg-turbo8 \
		libopenjp2-7 \
		libwebp6 \
		libjson-c5 \
		libgeos-c1v5 \
		liblapack3 \
		libagg2 \
		libdb5.3 \
		libexpat1 \
		libffi7 \
		libbz2-1.0 \
		liblzma5 \
		libblosc1 \
		libbrotli1 \
		liblcms2-2 \
		libjxr0 \
		liblz4-1 \
		libsnappy1v5 \
		libzopfli1 \
		libxcb1 \
		libllvm11 \
		sqlite3 \
		curl \
		git \
		locales \
		less \
		nano \
		ca-certificates && \
	apt-get -y purge gnupg && \
	apt-get -y autoremove && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	locale-gen en_US.UTF-8 && \
	echo /opt/proj/lib > /etc/ld.so.conf.d/optproj.conf && \
	ldconfig

ENV \
	PATH=/usr/local/pyenv/shims:/usr/local/pyenv/bin:/opt/proj/bin:$PATH \
	PROJ_NETWORK=ON \
	PROJ_DIR=/opt/proj \
	PROJ_LIB=/opt/proj/share/proj \
	PYENV_ROOT=/usr/local/pyenv \
	PIP=pip \
	LANG=en_US.UTF-8

RUN \
	pyenv rehash && \
	${PIP} check && \
	python3 -c "import matplotlib.font_manager, salem" && \
	mkdir /work

ADD test.sh /root/test.sh
