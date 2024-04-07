PYTHON_VERSION ?= 3
PROJ_VERSION ?= 9.4.0
GDAL_VERSION ?= 3.8.5

DEV_TAG ?= ghcr.io/oggm/dev_base:latest
EMPTY_TAG ?= ghcr.io/oggm/empty_base:latest

all: Dockerfile Dockerfile_dev Dockerfile_empty Dockerfile_final

Dockerfile: Dockerfile.in
	m4 \
		-D xxPYTHON_VERSION="$(PYTHON_VERSION)" \
		-D xxPROJ_VERSION="$(PROJ_VERSION)" \
		-D xxGDAL_VERSION="$(GDAL_VERSION)" \
		-D xxDEV_TAG="builder" \
		--prefix-builtins $< >$@

Dockerfile_dev: Dockerfile_dev.in
	m4 \
		-D xxPYTHON_VERSION="$(PYTHON_VERSION)" \
		-D xxPROJ_VERSION="$(PROJ_VERSION)" \
		-D xxGDAL_VERSION="$(GDAL_VERSION)" \
		-D xxDEV_TAG="builder" \
		--prefix-builtins $< >$@

Dockerfile_empty: Dockerfile_empty.in
	m4 \
		-D xxPYTHON_VERSION="$(PYTHON_VERSION)" \
		-D xxPROJ_VERSION="$(PROJ_VERSION)" \
		-D xxGDAL_VERSION="$(GDAL_VERSION)" \
		--prefix-builtins $< >$@

Dockerfile_final: Dockerfile_final.in
	m4 \
		-D xxPYTHON_VERSION="$(PYTHON_VERSION)" \
		-D xxPROJ_VERSION="$(PROJ_VERSION)" \
		-D xxGDAL_VERSION="$(GDAL_VERSION)" \
		-D xxDEV_TAG="$(DEV_TAG)" \
		-D xxEMPTY_TAG="$(EMPTY_TAG)" \
		--prefix-builtins $< >$@

.PHONY: all Dockerfile Dockerfile_dev Dockerfile_empty Dockerfile_final
