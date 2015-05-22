FROM ubuntu:14.04
MAINTAINER Alexandr Krylovskiy "alexandr.krylovskiy@fit.fraunhofer.de"

# update distribution
RUN apt-get update
# install some tools
RUN apt-get install -y wget unzip git openssl nmap mc nano curl jq

# install the fraunhofer certificate
RUN wget http://cdp1.pca.dfn.de/fraunhofer-ca/pub/cacert/cacert.pem -O /usr/local/share/ca-certificates/fhg.crt
RUN update-ca-certificates

# setup local connect home
ENV LSLC_HOME /opt/lslc
