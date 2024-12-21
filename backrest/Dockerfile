# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILDARCH
ARG TARGETARCH

# Execute during the build of the image
# ARG TEMPIO_VERSION BUILD_ARCH
#RUN \
#    curl -sSLf -o /usr/bin/tempio \
#    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

RUN apk --no-cache add ca-certificates curl bash rclone openssh tzdata bash

# RUN if [ $BUILDARCH = "arm64" ]; then \
#         mkdir /tmp/backrest/ && cd /tmp/ && wget https://github.com/garethgeorge/backrest/releases/download/v1.6.2/backrest_Linux_arm64.tar.gz \
#         cd /tmp/backrest/ && tar -zxvf /tmp/backrest_Linux_arm64.tar.gz && cp /tmp/backrest/backrest /usr/bin/backrest \
#     ; fi
    
# RUN if [ $BUILDARCH = "amd64" ]; then \
#         mkdir /tmp/backrest/ && cd /tmp/ && wget https://github.com/garethgeorge/backrest/releases/download/v1.6.2/backrest_Linux_x86_64.tar.gz \
#         cd /tmp/backrest/ && tar -zxvf /tmp/backrest_Linux_x86_64.tar.gz && cp /tmp/backrest/backrest /usr/bin/backrest \
#     ; fi    

# RUN /usr/bin/backrest --install-deps-only

# Copy root filesystem
COPY rootfs /

RUN /install.sh


