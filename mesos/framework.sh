#!/bin/sh

env

# exec /mesos/arangodb-framework --http-port=8181 --webui=http://${HOST}:8181/ "$@"
exec /mesos/arangodb-framework --http-port=${PORT0} --webui=http://${HOST}:${PORT0}/ "$@"
