###################################################
# Dockerfile to build a Python environment
# with OGGM and Jupyter installed.
###################################################

FROM ghcr.io/oggm/oggm:latest

RUN $PIP install --no-cache-dir jupyter pyzmq

EXPOSE 5000
CMD jupyter-notebook --port=5000 --ip=0.0.0.0
