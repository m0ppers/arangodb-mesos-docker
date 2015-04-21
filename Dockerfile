FROM ubuntu:14.04
MAINTAINER Frank Celler <info@arangodb.com>

# for local installation, uncomment
# ADD ./arangodb /install

# add scripts to install and run ArangoDB
ADD ./scripts /scripts

# add HELP file
ADD ./HELP.md /HELP.md

# install ubuntu package
RUN ./scripts/install.sh

# add mesos framework files
ADD ./mesos /mesos

# expose data, apps and logs
VOLUME ["/data", "/apps", "/apps-dev", "/logs"]

# standard ports
EXPOSE 8529

# start script
ENTRYPOINT ["/mesos/commands.sh"]
CMD ["help"]
