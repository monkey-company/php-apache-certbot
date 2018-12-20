#!/bin/bash

FROM webdevops/php-apache:ubuntu-16.04

#variables
ENV DOMAINS="domain.tld"
ENV EMAIL="admin@$DOMAINS"
ENV SHFILE="/opt/docker/etc/httpd/file.sh"
ENV PAGESPEED="false"
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
    wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb ; \
    dpkg -i mod-pagespeed-*.deb ; \
    apt-get -f install ; \
    rm -rf mod-pagespeed-*.deb ; \
    service apache2 restart ; \
    else echo "Without pagespeed" ; \
    fi
RUN array=(`echo $MODULES | sed 's/,/\n/g'`)
RUN for element in "${array[@]}"; do a2enmod "$element"; done
#apache modules
#COPY modules.sh .
#RUN chmod +x ./modules.sh
#CMD ./modules.sh
#change host
#RUN echo $(head -1 /etc/hosts | cut -f1) $DOMAINS >> /etc/hosts

#apply changes
RUN service apache2 restart
#run other script (cron, modules, etc)
RUN if [ ! -f "$SHFILE" ] ; then echo file not found ; else chmod +x $SHFILE && $SHFILE ; fi
