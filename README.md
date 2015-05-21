LinkSmart LocalConnect Development
======
Build scripts, configuration files, etc for LocalConnect devlopment


PREQUISITES

A functioning Go environment is required to run the build scripts.
The build process was tested with Go 1.2.1

Gox should be installed on your system if you want build the binaries for all architectures.
Get gox and build the build toolchain with:

go get github.com/mitchellh/gox
gox -build-toolchain

Also NodeJS and npm should be installed on your system. 
After npm is installed , install a additional plugin with:
npm install -g grunt


BUILD

To trigger build of all architectures call:

./setup.sh
./build-latest.sh

The builds will be found in ./dist


VERSIONING

This step can be skipped if you don't need versioning. Maven is used for versioning.
You can install a versioned version of the builds into your local Maven repository with:
mvn install


