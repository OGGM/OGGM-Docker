COPY --from=xxDEV_TAG /opt/proj /opt/proj
COPY --from=xxDEV_TAG /usr/local/pyenv /usr/local/pyenv

RUN \
    pyenv rehash && \
    ${PIP} check && \
    python3 -c "import matplotlib.font_manager, salem" && \
    mkdir /work

ADD test.sh /root/test.sh
