#!/bin/sh

if test -z "$ARANGODB_WEBUI";  then
  if test "$ARANGODB_WEBUI_USE_HOST" = "yes";  then
    ARANGODB_WEBUI=http://${HOST}:${PORT0}/
  else
    ARANGODB_WEBUI=http://${HOSTNAME}:${PORT0}/
  fi
fi

env

exec /mesos/arangodb-framework "--http-port=${PORT0}" "--webui=${ARANGODB_WEBUI}" "$@"
