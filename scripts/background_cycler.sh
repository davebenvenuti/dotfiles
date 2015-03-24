#!/bin/bash

backgrounds_dir=~/Backgrounds

if [ -d $backgrounds_dir ] && [ "$(ls -A $backgrounds_dir)" ]; then
    for x in $backgrounds_dir/*; do
        feh --bg-scale "$x" &
        sleep 15m
    done
else
    # Check for backgrounds again in a minute
    sleep 1m
fi

# Restart myself
bash $0 &

