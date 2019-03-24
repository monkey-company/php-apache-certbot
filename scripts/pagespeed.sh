#!/bin/sh

wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb
dpkg -i mod-pagespeed-*.deb || true
apt-get -f install
rm -rf mod-pagespeed-*.deb
service apache2 restart
