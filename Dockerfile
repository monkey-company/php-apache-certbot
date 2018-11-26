FROM webdevops/php-apache

ENV DOMAINS="domain.tld"
ENV EMAIL="admin@$DOMAINS"
ENV SHFILE="/opt/docker/etc/httpd/file.sh"
ENV PAGESPEED="false"

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:certbot/certbot -y
RUN apt-get update
RUN apt install python-certbot-apache -y
RUN echo "certbot --apache --non-interactive --agree-tos --email $EMAIL --domains $DOMAINS certonly"
RUN if [ ! -f "$SHFILE" ] ; then echo file not found ; else chmod +x $SHFILE && $SHFILE ; fi
RUN if [ "${PAGESPEED}" = "true" ] ; then wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb && dpkg -i mod-pagespeed-*.deb && sudo apt-get -f install && rm -rf mod-pagespeed-*.deb ; else echo cache disabled ; fi
RUN apt-get update
RUN apt-get upgrade -y
RUN /etc/init.d/apache2 restart
