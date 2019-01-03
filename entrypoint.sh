#!/bin/bash

echo $MODULES | sed 's/,/ /g' | a2enmod
#apply changes
service apache2 restart
#run other script (cron, modules, etc)
if [ ! -f "$SHFILE" ] ; then echo file not found ; else chmod +x $SHFILE && $SHFILE ; fi
