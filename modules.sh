#!/bin/bash

if [ -z "$MODULES" ]; then 
  echo "Without modules"
else 
  IFS=',' read -a array <<< "$MODULES"
  for element in "${array[@]}"; do 
    a2enmod "$element"
  done
fi
