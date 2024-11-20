#!/usr/bin/with-contenv bashio



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

RANDOMVAR=$(openssl rand -hex 6)

request() {

 #echo 'curl "${URL}" --data "${1}"'
  curl "${URL}" --data "${1}"
}

URL="http://${ROOTER_HOSTNAME}/cgi-bin/luci/rpc/auth"

TOKEN=$(request "{ \"id\": 1, \"method\": \"login\", \"params\": [ \"${ROOTER_USERNAME}\", \"${ROOTER_PASSWORD}\" ] }" | jq .result | tr -d '"' )


URL="http://${ROOTER_HOSTNAME}/ubus/?${RANDOMVAR}"

DATA=$(request "[{\"jsonrpc\":\"2.0\",\"method\":\"call\",\"params\":[\"${TOKEN}\",\"luci-rpc\",\"getWirelessDevices\",{}]}]")

PHY0_STA0=$(echo $DATA | jq  '.[0].result[1].["radio0"].["interfaces"].[] | select( .ifname == "phy0-sta0")')

#echo $DATA

MODEMDATA=$(curl -s -vv -H "cookie: sysauth_http=$TOKEN" "http://${ROOTER_HOSTNAME}/cgi-bin/luci/admin/modem/get_csq?${RANDOMVAR}")


#echo $MODEMDATA

mosquitto_pub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASSWORD" -t "rooter/phy0-sta0" -m "$PHY0_STA0"
mosquitto_pub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASSWORD" -t "rooter/modem" -m "$MODEMDATA"
