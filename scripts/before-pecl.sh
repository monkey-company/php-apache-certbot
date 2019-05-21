#!/bin/bash

#xdiff library
cd /usr/src
wget http://www.xmailserver.org/libxdiff-0.22.tar.gz
tar -xzf libxdiff-0.22.tar.gz
cd libxdiff-0.22
./configure
make
make install
