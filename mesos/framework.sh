#!/bin/sh

if test -z "$ARANGODB_WEBUI_HOST";  then
  if test "$ARANGODB_WEBUI_USE_HOSTNAME" = "yes";  then
    ARANGODB_WEBUI=http://${HOSTNAME}:${PORT0}/
  else
    ARANGODB_WEBUI=http://${HOST}:${PORT0}/
  fi
else
  ARANGODB_WEBUI="http://${ARANGODB_WEBUI_HOST}:${PORT0}/"
fi

env

exec /mesos/arangodb-framework "--http-port=${PORT0}" "--webui=${ARANGODB_WEBUI}" "$@"
