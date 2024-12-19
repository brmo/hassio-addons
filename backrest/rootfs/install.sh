#!/bin/bash

if [ $TARGETARCH = "arm64" ]; then \
        mkdir /tmp/backrest/ && cd /tmp/ && wget https://github.com/garethgeorge/backrest/releases/download/v1.6.2/backrest_Linux_arm64.tar.gz && \
        cd /tmp/backrest/ && tar -zxvf /tmp/backrest_Linux_arm64.tar.gz && cp /tmp/backrest/backrest /usr/bin/backrest
elif [ $TARGETARCH = "amd64" ]; then \
        mkdir /tmp/backrest/ && cd /tmp/ && wget https://github.com/garethgeorge/backrest/releases/download/v1.6.2/backrest_Linux_x86_64.tar.gz && \
        cd /tmp/backrest/ && tar -zxvf /tmp/backrest_Linux_x86_64.tar.gz && cp /tmp/backrest/backrest /usr/bin/backrest
fi    

/usr/bin/backrest --install-deps-only
