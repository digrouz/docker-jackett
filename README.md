[![auto-update](https://github.com/digrouz/docker-jackett/actions/workflows/auto-update.yml/badge.svg)](https://github.com/digrouz/docker-jackett/actions/workflows/auto-update.yml)
[![update-alpine](https://github.com/digrouz/docker-jackett/actions/workflows/update-alpine.yml/badge.svg)](https://github.com/digrouz/docker-jackett/actions/workflows/update-alpine.yml)
[![dockerhub](https://github.com/digrouz/docker-jackett/actions/workflows/dockerhub.yml/badge.svg)](https://github.com/digrouz/docker-jackett/actions/workflows/dockerhub.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/digrouz/jackett)

# docker-jackett
Installs Jackett into a Linux Container


![jackett](https://github.com/Jackett/Jackett/blob/master/src//Jackett.Common/Content/jacket_medium.png)

## Tag
Several tag are available:
* latest: see alpine-core
* alpine: see alpine-core
* alpine-core: [Dockerfile_alpine-core](https://github.com/digrouz/docker-jackett/blob/master/Dockerfile_alpine-core)

## Description

Jackett works as a proxy server: it translates queries from apps (Sonarr, SickRage, CouchPotato, Mylar, etc) into tracker-site-specific http queries, parses the html response, then sends results back to the requesting software. This allows for getting recent uploads (like RSS) and performing searches. Jackett is a single repository of maintained indexer scraping & translation logic - removing the burden from other apps.

Developer note: The software implements the Torznab (with nZEDb category numbering) and TorrentPotato APIs.

https://github.com/Jackett/Jackett

## Usage
    docker create --name=jackett \
      -v <path to config>:/config \
      -v <path to downloads>:/downloads \
      -e UID=<UID default:12345> \
      -e GID=<GID default:12345> \
      -e AUTOUPGRADE=<0|1 default:0> \
      -e TZ=<timezone default:Europe/Brussels> \
      -p 9117:9117 \
      digrouz/jackett

## Environment Variables

When you start the `jackett` image, you can adjust the configuration of the `jackett` instance by passing one or more environment variables on the `docker run` command line.

### `UID`

This variable is not mandatory and specifies the user id that will be set to run the application. It has default value `12345`.

### `GID`

This variable is not mandatory and specifies the group id that will be set to run the application. It has default value `12345`.

### `AUTOUPGRADE`

This variable is not mandatory and specifies if the container has to launch software update at startup or not. Valid values are `0` and `1`. It has default value `0`.

### `TZ`

This variable is not mandatory and specifies the timezone to be configured within the container. It has default value `Europe/Brussels`.

## Notes

* This container is built using [s6-overlay](https://github.com/just-containers/s6-overlay)
* The docker entrypoint can upgrade operating system at each startup. To enable this feature, just add `-e AUTOUPGRADE=1` at container creation.

## Issues

If you encounter an issue please open a ticket at [github](https://github.com/digrouz/docker-jackett/issues)
