#!/bin/sh

env
exec /mesos/arangodb-framework --http-port=${PORT0} --webui=http://${HOST}:${PORT0}/ "$@"
