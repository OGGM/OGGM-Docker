###################################################
# Dockerfile to build a Python 3.5 environment
# with OGGM and Jupyter installed.
###################################################

FROM oggm/base:latest
MAINTAINER Timo Rothenpieler

RUN apt-get -y install python3-zmq
RUN pip3 install jupyter

EXPOSE 5000
CMD jupyter-notebook --port=5000 --ip=0.0.0.0

