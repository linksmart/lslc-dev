FROM golang:1.8-alpine

# get dependencies
RUN apk add --no-cache git bash python

# copy config files
COPY conf/device-gateway.json /conf/
COPY conf/devices /conf/devices
WORKDIR /home

# get the code
RUN git clone https://linksmart.eu/redmine/linksmart-opensource/linksmart-local-connect/lslc-core.git
WORKDIR lslc-core

# make a symbolic link to gb-vendored dependencies
RUN ln -s ../vendor/src src/vendor

# build code
ENV GOPATH /home/lslc-core
RUN go install linksmart.eu/lc/core/cmd/device-gateway

VOLUME /conf
EXPOSE 8080

ENTRYPOINT ["./bin/device-gateway"]
CMD ["-conf", "/conf/device-gateway.json"]
