#!/bin/bash
FROM ubuntu:bionic
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

#variables
ENV DEBIAN_FRONTEND="noninteractive" \
  	TZ="Europe/Paris" \
    DOMAIN="localhost" \
    EMAIL="admin@$DOMAIN" \
    SHFILE="/etc/apache2/file.sh" \
    PAGESPEED="true" \
    LIBMOD="re2c" \
    APAMOD="cache,rewrite,ssl" \
    APDMOD="autoindex" \
    PHPMOD="bcmath,bz2,intl,gd,mbstring,mysql,zip" \
    PEAMOD="xdiff-beta"

WORKDIR /

COPY ./scripts /scripts
COPY ./entrypoint-custom /
RUN chmod +x /entrypoint-custom
RUN chmod +x /scripts/*
ENTRYPOINT ["/entrypoint-custom"]
CMD ["run"]
