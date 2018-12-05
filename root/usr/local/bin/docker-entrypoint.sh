#!/usr/bin/env bash
 
. /etc/profile
. /usr/local/bin/docker-entrypoint-functions.sh

MYUSER="${APPUSER}"
MYUID="${APPUID}"
MYGID="${APPGID}"

ConfigureUser
AutoUpgrade

if [ "$1" = 'jackett' ]; then
  if [ -d  /opt/Jackett ]; then
    chown -R "${MYUSER}":"${MYUSER}" /opt/Jackett
    chmod 0755 /opt/Jackett
  fi
  if [ -d  /config ]; then
    chown -R "${MYUSER}":"${MYUSER}" /config
  fi
  
  RunDropletEntrypoint
  
  DockLog "Starting app: ${@}"
  exec su - "${MYUSER}" -s /bin/bash -c "mono /opt/Jackett/JackettConsole.exe" 
else
  DockLog "Starting command: ${@}"
  exec "$@"
fi
