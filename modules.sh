#!/bin/bash

if [ ! -z "$MODULES" ]; then 
  IFS=',' read -a array <<< "$MODULES"
  for element in "${array[@]}"; do 
    a2enmod "$element"
  done
fi
