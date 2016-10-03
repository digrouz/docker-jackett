# docker-alp-jackett
Installs Jackett into an Alpine Linux Container


![jackett](https://github.com/Jackett/Jackett/blob/master/src/Jackett/Content/jacket_medium.png)

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
      -p 9117:9117 \
      digrouz/docker-alp-jackett

## Environment Variables

When you start the `jackett` image, you can adjust the configuration of the `jackett` instance by passing one or more environment variables on the `docker run` command line.

### `DOCKUID`

This variable is not mandatory and specifies the user id that will be set to run the application. It has default value `10008`.

### `DOCKGID`

This variable is not mandatory and specifies the group id that will be set to run the application. It has default value `10008`.

