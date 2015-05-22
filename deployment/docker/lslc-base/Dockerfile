FROM ubuntu:14.04
MAINTAINER Alexandr Krylovskiy "alexandr.krylovskiy@fit.fraunhofer.de"
RUN apt-get update
RUN apt-get install -y wget unzip
RUN wget https://linksmart.eu/redmine/attachments/download/3409/lslc-0.2.0-rc1_linux_amd64.zip
RUN unzip lslc-0.2.0-rc1_linux_amd64.zip
RUN mv lslc-0.2.0-rc1_linux_amd64 /opt/lslc
ENV LSLC_HOME /opt/lslc
