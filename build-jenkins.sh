#!/bin/bash -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir "$DIR/build"
cd "$DIR/build"

export GOPATH=`pwd`
echo "GOROOT: $GOROOT"

# Project code
mkdir -p src/linksmart.eu/lc 
git clone https://linksmart.eu/redmine/linksmart-opensource/linksmart-local-connect/lslc-core.git src/linksmart.eu/lc/core

# Get the version from pom.xml
VERSION=$(xmllint --xpath "string(//version)" "$DIR/pom.xml")

echo "VERSION: $VERSION"

# setup environment
"$DIR/setup.sh"

# build
"$DIR/release.sh" "$VERSION"

# clean up
rm -rf "$DIR/build/"

echo "Latest build is available in ./dist:"
ls -1 "$DIR/dist"

exit 0
