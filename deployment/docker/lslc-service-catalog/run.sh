#!/bin/sh
# starts the service catalog inside a docker container. The service  runs under http://localhost:8082/sc
docker run -d -p 8082:8082 --name="lslc-service-catalog" lslc/service-catalog
