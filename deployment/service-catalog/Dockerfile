FROM golang:1.8-alpine

# get dependencies
RUN apk add --no-cache git

# copy config file
COPY conf/service-catalog.json /conf/
WORKDIR /home

# get the code
RUN git clone https://linksmart.eu/redmine/linksmart-opensource/linksmart-local-connect/lslc-core.git
WORKDIR lslc-core

# make a symbolic link to gb-vendored dependencies
RUN ln -s ../vendor/src src/vendor

# build code
ENV GOPATH /home/lslc-core
RUN go install linksmart.eu/lc/core/cmd/service-catalog

VOLUME /conf /data
EXPOSE 8082

ENTRYPOINT ["./bin/service-catalog"]
CMD ["-conf", "/conf/service-catalog.json"]
