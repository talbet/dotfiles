#!/usr/bin/env bash

# Get unique number from MAC address
# ID=$((0x$(ifconfig en0 | awk '/ether/{print $2}'| tail -c 3)))

Serial=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | md5 | tail -c 3)
ID=$((0x${Serial}))

#Get name from names file
sed -n "${ID}p" ./names