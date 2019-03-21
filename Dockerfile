#!/bin/bash
FROM ubuntu:bionic
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

#variables
ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ="Europe/Paris"
ENV DOMAINS="domain.tld"
ENV EMAIL="admin@$DOMAINS"
ENV SHFILE="/opt/docker/etc/httpd/file.sh"
ENV PAGESPEED="true"
ENV LIBMOD="re2c"
ENV APAMOD="cache,rewrite"
ENV PHPMOD="bcmath,bz2,intl,gd,mbstring,mysql,zip"
ENV PEAMOD="xdiff-beta"

WORKDIR /

COPY ./entrypoint-custom /
RUN chmod +x /entrypoint-custom
ENTRYPOINT ["/entrypoint-custom"]
CMD ["run"]
