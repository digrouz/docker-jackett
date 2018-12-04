FROM alpine:3.8
LABEL maintainer "DI GREGORIO Nicolas <nicolas.digregorio@gmail.com>"

### Environment variables
ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm' \
    APPUSER='jackett' \
    APPUID='10008' \
    APPGID='10008' \
    XDG_DATA_HOME='/config' \
    XDG_CONFIG_HOME='/config'
    
### Copy config files
COPY root/ /

### Install Application
RUN set -x && \
    chmod 1777 /tmp && \
    . /usr/local/bin/docker-entrypoint-functions.sh && \
    MYUSER="${APPUSER}" && \
    MYUID="${APPUID}" && \
    MYGID="${APPGID}" && \
    ConfigureUser && \
    apk upgrade --no-cache && \
    apk add --no-cache --virtual=build-deps \
      ca-certificates \
      wget \
    && \
    apk add --no-cache --virtual=run-deps \
      libcurl \
      python \
      su-exec \
      bash \
    && \
    apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing --virtual=run-deps-testing \
      mono \
    && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    mkdir -p /opt/Jackett && \
    RELEASE=$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep -E \/tag\/ | awk -F "[><]" '{print $3}' | tail -n 1) && \
    wget -q https://github.com/Jackett/Jackett/releases/download/${RELEASE}/Jackett.Binaries.Mono.tar.gz -O /tmp/jacket.tar.gz && \
    tar xzf /tmp/jacket.tar.gz -C /opt && \
    apk del --no-cache --purge \
      build-deps  \
    && \
    mkdir /docker-entrypoint.d && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    ln -snf /usr/local/bin/docker-entrypoint.sh /docker-entrypoint.sh && \
    rm -rf /tmp/* \
           /var/cache/apk/*  \
           /var/tmp/*
    
### Volume
Volume ["/config","/downloads"]

### Expose ports
Expose 9117

### Running User: not used, managed by docker-entrypoint.sh
#USER jackett

### Start jackett
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["jackett"]
