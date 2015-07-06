# arangodb-mesos-docker
ArangoDB docker container for Mesos

The container is built with the stripped executable compiled from the
github repository

  https://github.com/ArangoDB/arangodb-mesos

Builds are numbered and each build has a signed tag in that repository.
The tag of the repository must be put into the file 

  mesos/BUILDTAG

whenever the docker image is built.
