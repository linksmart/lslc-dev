#!/bin/sh
MAVEN_METADATA=maven-metadata.xml
ARTIFACT_NAME="linux-amd64.main.deployable"
REPO_URL="https://linksmart.eu/repo/content/repositories/public/eu/linksmart/lc/distribution/$ARTIFACT_NAME/0.1.0/"
echo "maven metadata file : $MAVEN_METADATA"
echo "repo url : $REPO_URL"
# retrieve maven metadata to get latest distribution artifact
wget $REPO_URL$MAVEN_METADATA
# extract latest version over xpath
export LSLC_BUILD=$(xmllint --xpath "string(//metadata/versioning/snapshotVersions/snapshotVersion[2]/value)" $MAVEN_METADATA)
echo "current LSLC build: $LSLC_BUILD"
# grab latest binary distribution from artifact server
wget $REPO_URL$ARTIFACT_NAME-$LSLC_BUILD-distribution.tar.gz
export LSLC_DIST_FILE=$ARTIFACT_NAME-$LSLC_BUILD-distribution.tar.gz
# construct a docker file from template
envsubst '$LSLC_DIST_FILE' < Dockerfile.template > Dockerfile
# create docker image
# USE sudo if your user doesn't have sufficient rights
# for permanent right follow https://docs.docker.com/installation/debian/#debian-wheezystable-7x-64-bit
docker build -rm -t lslc/distribution .
# clean up temporary files
rm Dockerfile
rm $MAVEN_METADATA
rm $LSLC_DIST_FILE

#https://linksmart.eu/repo/content/repositories/public/eu/linksmart/lc/distribution/linux-amd64.main.deployable/0.2.0-SNAPSHOT/
