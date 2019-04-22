#!/bin/bash
FROM ubuntu:bionic
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

#variables
ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ="Europe/Paris"
ENV DOMAIN="localhost"
ENV EMAIL="admin@$DOMAIN"
ENV SHFILE="/opt/docker/etc/httpd/file.sh"
ENV PAGESPEED="true"
ENV LIBMOD="re2c"
ENV APAMOD="cache,rewrite"
ENV PHPMOD="bcmath,bz2,intl,gd,mbstring,mysql,zip"
ENV PEAMOD="xdiff-beta"

WORKDIR /

COPY ./scripts /scripts
COPY ./entrypoint-custom /
RUN chmod +x /entrypoint-custom
RUN chmod +x /scripts/*
ENTRYPOINT ["/entrypoint-custom"]
CMD ["run"]
