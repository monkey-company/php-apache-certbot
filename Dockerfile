#!/bin/bash
FROM ubuntu:focal
#RUN rm /bin/sh && ln -s /bin/bash /bin/sh

    #variables
ENV DEBIAN_FRONTEND="noninteractive" \
  	TZ="Europe/Paris" \
    DOMAIN="localhost" \
    EMAIL="admin@localhost" \
    SHFILE="/etc/apache2/file.sh" \
    PAGESPEED="true" \
    LIBMOD="re2c,bsdiff" \
    APAMOD="cache,rewrite,ssl,headers" \
    APDMOD="autoindex" \
    PHPMOD="bcmath,bz2,intl,gd,mbstring,mysql,zip" \
    PEAMOD="xdiff-beta"

WORKDIR /

    #set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \

    #update repo
    apt-get update && apt-get upgrade -y && \

    #install dependencies
    apt-get install software-properties-common apt-utils wget -y

    #install apache
RUN apt-get install apache2 -y && \
    service apache2 stop && \

    #install php and dependencies
    apt-get install php php-dev php-pear libapache2-mod-php -y && \

    #install certbot, sendmail and ssmtp for ssl and mails
    apt update && \
    apt install python3 python3-venv libaugeas0 -y && \
    python3 -m venv /opt/certbot/ && \
    /opt/certbot/bin/pip install --upgrade pip && \
    /opt/certbot/bin/pip install certbot certbot-apache && \
    ln -s /opt/certbot/bin/certbot /usr/bin/certbot


COPY ./scripts /scripts
COPY ./entrypoint-custom /
RUN chmod +x /entrypoint-custom
RUN chmod +x /scripts/*
ENTRYPOINT ["/entrypoint-custom"]
CMD ["run"]
