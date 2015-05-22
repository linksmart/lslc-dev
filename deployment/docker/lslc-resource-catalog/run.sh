#!/bin/sh
# starts the resource catalog docker container. The service  runs under http://localhost:8081/rc
docker run -d -p 8081:8081 --name="lslc-resource-catalog" lslc/resource-catalog
