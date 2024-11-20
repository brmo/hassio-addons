# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

CONFIG_PATH=/data/options.json


if bashio::services.available mqtt ; then
  export MQTT_HOST="$(bashio::services mqtt 'host')"
  export MQTT_PORT="$(bashio::services mqtt 'port')"
  export MQTT_USER="$(bashio::services mqtt 'username')"
  export MQTT_PASSWORD="$(bashio::services mqtt 'password')"
fi

export ROOTER_HOSTNAME="$(bashio::config 'rooter_hostname')"
export ROOTER_USERNAME="$(bashio::config 'rooter_username')"
export ROOTER_PASSWORD="$(bashio::config 'rooter_password')"

RUN apk --no-cache add ca-certificates curl bash jq yq

COPY rootfs /

ENTRYPOINT ['/etc/grabData.sh']
