#!/bin/sh

env

export WEBUI="http://${HOST}:${PORT}/"
export ARANGODB_HTTP_PORT="${PORT}"

exec /mesos/arangodb-framework "$@"
