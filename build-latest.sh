#!/bin/bash -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir "$DIR/build"
cd "$DIR/build"

export GOPATH=`pwd`

# Project code
mkdir -p src/linksmart.eu/lc 
git clone https://linksmart.eu/redmine/linksmart-opensource/linksmart-local-connect/lslc-core.git src/linksmart.eu/lc/core

# Install build dependencies
go get github.com/mitchellh/gox

# setup environment
"$DIR/setup.sh"

# build
"$DIR/release.sh" "latest"

# clean up
rm -rf "$DIR/build/"

echo "Latest build is available in ./dist:"
ls -1 "$DIR/dist"

exit 0
