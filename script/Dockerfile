FROM ubuntu:latest
RUN apt-get update && chmod +x ./bootstrap.sh && ./bootstrap.sh

FROM centos
RUN yum update && chmod +x ./bootstrap.sh && ./bootstrap.sh