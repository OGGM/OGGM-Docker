COPY --from=xxDEV_TAG /opt/proj /opt/proj
COPY --from=xxDEV_TAG /usr/local/pyenv /usr/local/pyenv

RUN \
    echo /opt/proj/lib > /etc/ld.so.conf.d/optproj.conf && \
    ldconfig && \
    pyenv rehash && \
    ${PIP} check && \
    python3 -c "import fiona, matplotlib.font_manager, salem" && \
    mkdir /work

ADD test.sh /root/test.sh
