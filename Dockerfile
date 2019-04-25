#!/bin/bash
FROM ubuntu:bionic
#RUN rm /bin/sh && ln -s /bin/bash /bin/sh

    #variables
ENV DEBIAN_FRONTEND="noninteractive" \
  	TZ="Europe/Paris" \
    DOMAIN="localhost" \
    EMAIL="admin@localhost" \
    SHFILE="/etc/apache2/file.sh" \
    PAGESPEED="true" \
    LIBMOD="re2c" \
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
    add-apt-repository ppa:certbot/certbot -y && \
    apt-get update && \
    apt-get install sendmail-bin sendmail ssmtp python-certbot-apache -y

COPY ./scripts /scripts
COPY ./entrypoint-custom /
RUN chmod +x /entrypoint-custom
RUN chmod +x /scripts/*
ENTRYPOINT ["/entrypoint-custom"]
CMD ["run"]
