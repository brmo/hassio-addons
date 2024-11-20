# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

#RUN apk --no-cache add ca-certificates curl bash jq yq

COPY rootfs /

RUN chmod +x /run.sh

ENTRYPOINT ['/run.sh']
