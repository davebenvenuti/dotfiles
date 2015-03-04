#!/usr/bin/env python

import sys

current_fd = open('/sys/class/power_supply/BAT0/charge_now', 'r')
current = current_fd.read()
current_fd.close()

full_fd = open('/sys/class/power_supply/BAT0/charge_full', 'r')
full = full_fd.read()
full_fd.close()

arg_count = len(sys.argv)

if arg_count > 1:
    decimal_places = int(sys.argv[arg_count - 1])
else:
    decimal_places = 2

mask = "%%.%df%%%%" % decimal_places

print mask % round(((float(current) / float(full)) * 100), 2)

