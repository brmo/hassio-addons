# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

#RUN apk --no-cache add ca-certificates curl bash jq yq

RUN apk --no-cache add nano openssl

COPY rootfs /

WORKDIR /app

ENV EDITOR nano

RUN echo "*/1 * * * * /app/run.sh >> /var/log/cron.log 2>&1" >> /etc/crontabs/root

# Give execute permissions to the script
RUN chmod +x /app/run.sh

# Set the entrypoint to start cron
ENTRYPOINT ["crond", "-f"]
