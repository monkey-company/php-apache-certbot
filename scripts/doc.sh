#!/bin/sh

#run instructions after install
echo "Hey you ! Yes, please run this :" && echo

#start doc
echo "certbot --apache --non-interactive --agree-tos --email $EMAIL --domains $DOMAINS certonly"
echo "service apache2 restart"

#end doc
echo
