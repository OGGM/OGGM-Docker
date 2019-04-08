###################################################
# Dockerfile to build a Python 3.6 environment
# with OGGM and Jupyter installed.
###################################################

FROM oggm/oggm:latest

RUN pip3 install --no-cache-dir jupyter pyzmq

EXPOSE 5000
CMD jupyter-notebook --port=5000 --ip=0.0.0.0

