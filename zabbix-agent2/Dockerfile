# Stage 1: Pull the official multi-arch Zabbix Agent 2 Alpine image
FROM zabbix/zabbix-agent2:alpine-8.0-latest AS zabbix

# Stage 2: Home Assistant multi-arch Alpine base image
FROM ghcr.io/home-assistant/base:latest

ARG BUILD_ARCH
ARG BUILD_VERSION

# Install runtime dependencies required by zabbix_agent2 and plugins (e.g., smartctl, docker)
RUN apk add --no-cache \
    bash \
    curl \
    jq \
    pcre2 \
    smartmontools \
    zlib

# Copy Zabbix Agent 2 binary, plugin binaries, and default configs from Stage 1
COPY --from=zabbix /usr/sbin/zabbix_agent2 /usr/sbin/zabbix_agent2
COPY --from=zabbix /usr/sbin/zabbix-agent2-plugin/ /usr/sbin/zabbix-agent2-plugin/
COPY --from=zabbix /etc/zabbix/ /etc/zabbix/

# Create runtime directories and zabbix user/group if not present
RUN addgroup -S zabbix 2>/dev/null || true \
    && adduser -S -G zabbix -H -s /sbin/nologin zabbix 2>/dev/null || true \
    && mkdir -p /var/run/zabbix /var/log/zabbix /var/lib/zabbix \
    && chown -R zabbix:zabbix /var/run/zabbix /var/log/zabbix /var/lib/zabbix /etc/zabbix

# Copy your add-on rootfs (s6-overlay services / run scripts)
COPY rootfs /

# Standard Home Assistant labels
LABEL \
    io.hass.name="Zabbix Agent" \
    io.hass.description="zabbix-agent2" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}"
