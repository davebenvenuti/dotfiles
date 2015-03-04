#!/usr/bin/env bash

pactl list sinks | grep "Volume: 0" | tail -1 | awk -F : '{ print $4 }' | sed -e 's/^[[:space:]]*//'

