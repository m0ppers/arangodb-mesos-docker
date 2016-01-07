FROM arangodb/arangodb
MAINTAINER Frank Celler <info@arangodb.com>

# add scripts to install and run ArangoDB
ADD ./scripts /scripts

# add HELP file
ADD ./HELP.md /HELP.md

# install ubuntu package
RUN ./scripts/install.sh

# add mesos framework files
ADD ./mesos /mesos

# expose data, apps and logs
VOLUME ["/data", "/apps", "/logs"]

# standard ports for ArangoDB and etcd
EXPOSE 8529 4001 7001

# start script
ENTRYPOINT ["/mesos/commands.sh"]
CMD ["help"]
