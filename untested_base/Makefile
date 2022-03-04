PYTHON_VERSION ?= 3
PROJ_VERSION ?= 8.2.1
GDAL_VERSION ?= 3.4.1

all: Dockerfile

Dockerfile: Dockerfile.in
	m4 \
		-D xxPYTHON_VERSION="$(PYTHON_VERSION)" \
		-D xxPROJ_VERSION="$(PROJ_VERSION)" \
		-D xxGDAL_VERSION="$(GDAL_VERSION)" \
		--prefix-builtins $< >$@

.PHONY: all Dockerfile
