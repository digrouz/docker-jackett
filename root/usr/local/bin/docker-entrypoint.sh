#!/usr/bin/env bash
 
. /etc/profile
. /usr/local/bin/docker-entrypoint-functions.sh

MYUSER="${APPUSER}"
MYUID="${APPUID}"
MYGID="${APPGID}"

ConfigureUser
AutoUpgrade

if [ "$1" = 'jackett-mono' ]; then
  if [ -d  /config ]; then
    chown -R "${MYUSER}":"${MYUSER}" /config
  fi
 
  RunDropletEntrypoint
  
  DockLog "Starting app: ${@}"
  exec su-exec "${MYUSER}" mono /opt/Jackett/JackettConsole.exe
elif [ "$1" = 'jackett-core' ]; then
  if [ -d  /config ]; then
    chown -R "${MYUSER}":"${MYUSER}" /config
  fi
 
  RunDropletEntrypoint
  
  DockLog "Starting app: ${@}"
  exec su-exec "${MYUSER}" /opt/Jackett/jackett -d ${XDG_CONFIG_HOME} --NoUpdates --NoRestart
else
  DockLog "Starting command: ${@}"
  exec "$@"
fi
