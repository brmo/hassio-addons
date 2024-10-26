# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
# ARG TEMPIO_VERSION BUILD_ARCH
#RUN \
#    curl -sSLf -o /usr/bin/tempio \
#    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

RUN apk --no-cache add ca-certificates curl bash rclone openssh tzdata
RUN mkdir /tmp/backrest/ && cd /tmp/ && wget https://github.com/garethgeorge/backrest/releases/download/v1.6.1/backrest_Linux_x86_64.tar.gz
RUN cd /tmp/backrest/ && tar -zxvf /tmp/backrest_Linux_x86_64.tar.gz && cp /tmp/backrest/backrest /usr/bin/backrest
RUN /usr/bin/backrest --install-deps-only

# Copy root filesystem
COPY rootfs /
