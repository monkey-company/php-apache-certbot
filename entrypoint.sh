#!/bin/bash

#enable apache modules
IFS=', ' read -r -a array <<< "$MODULES"
for element in "${array[@]}"
do
    a2enmod $element
done

#run other script (cron, modules, etc)
if [ ! -f "$SHFILE" ]
then
  echo "file not found"
else
  chmod +x $SHFILE
  $SHFILE
fi
