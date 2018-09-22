FROM webdevops/php-apache

ENV DOMAINS="domain.tld"
ENV EMAIL="admin@$DOMAINS"

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:certbot/certbot -y
RUN apt-get update
RUN apt install python-certbot-apache -y
RUN echo "certbot --apache --non-interactive --agree-tos --email $EMAIL --domains $DOMAINS certonly"
