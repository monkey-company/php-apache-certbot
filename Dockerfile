#!/bin/bash
FROM webdevops/php-apache:ubuntu-16.04
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

#variables
ENV DOMAINS="domain.tld"
ENV EMAIL="admin@$DOMAINS"
ENV SHFILE="/opt/docker/etc/httpd/file.sh"
ENV PAGESPEED="true"
ENV MODULES=""

#update repo
RUN apt-get update && apt-get upgrade -y
#install dependencies
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:certbot/certbot -y
RUN apt-get update
RUN apt-get install sendmail -y
RUN apt-get install ssmtp -y
RUN apt install python-certbot-apache -y
RUN echo "certbot --apache --non-interactive --agree-tos --email $EMAIL --domains $DOMAINS certonly"
#google pagespeed option
RUN if [ "$PAGESPEED" = "true" ] ; then \
    wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb \
    && dpkg -i mod-pagespeed-*.deb || true ; \
    apt-get -f install ; \
    rm -rf mod-pagespeed-*.deb ; \
    service apache2 restart ; \
    else echo "Without pagespeed" ; \
    fi

WORKDIR /

COPY ./entrypoint-custom /
RUN chmod +x /entrypoint-custom
ENTRYPOINT ["/entrypoint-custom"]
CMD ["run"]
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
