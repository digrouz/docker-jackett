# vim:set ft=dockerfile:
FROM alpine:latest
MAINTAINER DI GREGORIO Nicolas <nicolas.digregorio@gmail.com>

### Environment variables
ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm' 

### Install Application
RUN apk upgrade --no-cache && \
    apk add --no-cache --virtual=build-deps \
      curl \
      wget && \
    apk add --no-cache --virtual=run-deps \
      libcurl
      su-exec && \
    apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing --virtual-run-deps-testing \
      mono && \
    mkdir -p /opt/Jackett
    RELEASE=$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep -E \/tag\/ | awk -F "[><]" '{print $3}') && \
    curl -o /tmp/jacket.tar.gz -L https://github.com/Jackett/Jackett/releases/download/${RELEASE}/Jackett.Binaries.Mono.tar.gz && \
    tar xzf /tmp/jacket.tar.gz -C /opt && \
    apk del --no-cache --purge \
      build-deps  && \
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
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["jackett"]
