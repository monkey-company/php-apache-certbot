#!/bin/sh

#enable apache modules
echo $MODULES | sed 's/,/ /g' | a2enmod

#run other script (cron, modules, etc)
if [ ! -f "$SHFILE" ] ; then echo file not found ; else chmod +x $SHFILE && $SHFILE ; fi
