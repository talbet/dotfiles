#!/usr/bin/env bash

# Get unique number from MAC address
UNIQUE_BY_MAC=$(ifconfig en0 | awk '/ether/{print $2}'| cksum | cut -f1 -d" ")
# UNIQUE_BY_SERIAL=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cksum | cut -f1 -d" ")

# Find how many names there are to choose from
SELECTION_LENGTH=$(cat names | wc -l | xargs)

# Use modulo to get an ID
ID=$(($UNIQUE_BY_MAC%$SELECTION_LENGTH))

# Get name from names file
# sed -n "${ID}p" ./names
sed "${ID}q;d" ./names