#!/bin/bash

#bsdiff extension
apt-get install bzip2 git -y
git clone https://github.com/monkey-company/phpdiff.git
cd phpdiff
phpize
export LDFLAGS="-lbz2" && ./configure --with-php-config=/php-path/bin/php-config
make && make install

#xdiff library
cd /usr/src
wget http://www.xmailserver.org/libxdiff-0.22.tar.gz
tar -xzf libxdiff-0.22.tar.gz
cd libxdiff-0.22
./configure
make
make install
