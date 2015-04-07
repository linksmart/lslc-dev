#!/bin/bash -e

VERSION=$1
OSARCHS=( "darwin/amd64" "linux/amd64" "linux/arm" "windows/amd64" "windows/386" );
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

if [ "$VERSION" = "" ]; then
    VERSION="DEV"
fi

if [ -d "$DIR/dist" ]; then
    rm -rf $DIR/dist/*
else
    mkdir -p $DIR/dist
fi


for v in "${OSARCHS[@]}"
do
    suffix=`echo "${v}" | tr / _`
    p="lslc-${VERSION}_${suffix}"
    d="${DIR}/dist/${p}"
    mkdir -p $d

    # Compile
    pushd $d
    gox -verbose -output="device-gateway" -osarch="${v}" linksmart.eu/lc/core/cmd/device-gateway
    gox -verbose -output="resource-catalog" -osarch="${v}" linksmart.eu/lc/core/cmd/resource-catalog
    gox -verbose -output="service-catalog" -osarch="${v}" linksmart.eu/lc/core/cmd/service-catalog
    gox -verbose -output="service-registrator" -osarch="${v}" linksmart.eu/lc/core/cmd/service-registrator
    popd

    # Copy configuration
    mkdir -p $d/conf/devices
    mkdir -p $d/conf/services
    cp -R ${DIR}/conf/*.json $d/conf/
    cp -R ${DIR}/conf/devices/*.json $d/conf/devices/
    cp -R ${DIR}/conf/services/*.json $d/conf/services/

    # Copy examples of agents
    mkdir $d/agent-examples
    cp -R ${DIR}/agent-examples/* $d/agent-examples

    # Copy static
    mkdir -p $d/static/
    cp -R ${DIR}/static/ctx $d/static/

    # Copy dashboard
    mkdir -p $d/static/dashboard/css
    cp -R ${DIR}/static/dashboard/css/freeboard.min.css $d/static/dashboard/css/
    mkdir -p $d/static/dashboard/img
    cp -R ${DIR}/static/dashboard/img/dropdown-arrow.png $d/static/dashboard/img/
    cp -R ${DIR}/static/dashboard/img/glyphicons-halflings-white.png $d/static/dashboard/img/
    cp -R ${DIR}/static/dashboard/img/glyphicons-halflings.png $d/static/dashboard/img/
    cp -R ${DIR}/static/dashboard/index.html $d/static/dashboard/
    mkdir -p $d/static/dashboard/js
    cp -R ${DIR}/static/dashboard/js/freeboard+plugins.min.js $d/static/dashboard/js/
    cp -R ${DIR}/static/dashboard/js/freeboard+plugins.min.js.map $d/static/dashboard/js/
    cp -R ${DIR}/static/dashboard/js/freeboard.min.js $d/static/dashboard/js/
    cp -R ${DIR}/static/dashboard/js/freeboard.min.js.map $d/static/dashboard/js/
    cp -R ${DIR}/static/dashboard/js/freeboard.plugins.min.js $d/static/dashboard/js/
    cp -R ${DIR}/static/dashboard/js/freeboard.plugins.min.js.map $d/static/dashboard/js/
    cp -R ${DIR}/static/dashboard/js/freeboard.thirdparty.min.js $d/static/dashboard/js/
    mkdir -p $d/static/dashboard/plugins/freeboard
    mkdir -p $d/static/dashboard/plugins/thirdparty
    cp -R ${DIR}/static/dashboard/plugins/freeboard/freeboard.datasources.js $d/static/dashboard/plugins/freeboard/
    cp -R ${DIR}/static/dashboard/plugins/freeboard/freeboard.widgets.js $d/static/dashboard/plugins/freeboard/
    cp -R ${DIR}/static/dashboard/plugins/thirdparty/jquery.sparkline.min.js $d/static/dashboard/plugins/thirdparty/
    cp -R ${DIR}/static/dashboard/plugins/thirdparty/justgage.1.0.1.js $d/static/dashboard/plugins/thirdparty/
    cp -R ${DIR}/static/dashboard/plugins/thirdparty/raphael.2.1.0.min.js $d/static/dashboard/plugins/thirdparty/

    # Copy docs
    #cp -R ${DIR}/docs $d/
    #cp wiki.pdf $d/

    # remove mac crap
    find $d/ -type f -name "._*" -exec rm -f {} \;

    cd $DIR/dist && /usr/bin/zip -9 -r "${p}.zip" "$p"
    # cd $DIR/dist && /usr/bin/tar -zcvf "${p}.tar.gz" $p
    rm -rf $d
done

echo "DONE!"
exit 0