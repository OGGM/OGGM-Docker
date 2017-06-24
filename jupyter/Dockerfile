###################################################
# Dockerfile to build a Python 3.5 environment
# with OGGM and Jupyter installed.
###################################################

FROM oggm/oggm:latest
MAINTAINER Timo Rothenpieler

RUN pip3 install jupyter pyzmq

EXPOSE 5000
CMD jupyter-notebook --port=5000 --ip=0.0.0.0

