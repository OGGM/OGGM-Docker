###################################################
# Dockerfile to build a Python 2.7 environment
# with OGGM and Jupyter installed.
###################################################

FROM oggm/base2:latest
MAINTAINER Timo Rothenpieler

RUN apt-get -y install python-zmq
RUN pip install jupyter

EXPOSE 5000
CMD jupyter-notebook --port=5000 --ip=0.0.0.0

