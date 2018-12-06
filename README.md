# docker-jackett
Installs Jackett into a Linux Container


![jackett](https://github.com/Jackett/Jackett/blob/master/src/Jackett/Content/jacket_medium.png)

## Tag
Several tag are available:
* latest: see centos7
* centos7: [centos7/Dokerfile](https://github.com/digrouz/docker-jackett/blob/master/Dockerfile-centos7)
* alpine3.8: [alpine3.8/Dockerfile](https://github.com/digrouz/docker-jackett/blob/master/Dockerfile-alpine3.8)

## Description

Jackett works as a proxy server: it translates queries from apps (Sonarr, SickRage, CouchPotato, Mylar, etc) into tracker-site-specific http queries, parses the html response, then sends results back to the requesting software. This allows for getting recent uploads (like RSS) and performing searches. Jackett is a single repository of maintained indexer scraping & translation logic - removing the burden from other apps.

Developer note: The software implements the Torznab (with nZEDb category numbering) and TorrentPotato APIs.

https://github.com/Jackett/Jackett

## Usage
    docker create --name=jackett \
      -v /etc/localtime:/etc/localtime:ro \
      -v <path to config>:/config \
      -v <path to downloads>:/downloads \
      -e DOCKUID=<UID default:10008> \
      -e DOCKGID=<GID default:10008> \
      -e DOCKUPGRADE=<0|1> \
      -p 9117:9117 \
      digrouz/jackett

## Environment Variables

When you start the `jackett` image, you can adjust the configuration of the `jackett` instance by passing one or more environment variables on the `docker run` command line.

### `DOCKUID`

This variable is not mandatory and specifies the user id that will be set to run the application. It has default value `10008`.

### `DOCKGID`

This variable is not mandatory and specifies the group id that will be set to run the application. It has default value `10008`.

### `DOCKUPGRADE`

This variable is not mandatory and specifies if the container has to launch software update at startup or not. Valid values are `0` and `1`. It has default value `0`.

## Notes

* The docker entrypoint can upgrade operating system at each startup. To enable this feature, just add `-e DOCKUPGRADE=1` at container creation.

## Issues

If you encounter an issue please open a ticket at [github](https://github.com/digrouz/docker-jackett/issues)
