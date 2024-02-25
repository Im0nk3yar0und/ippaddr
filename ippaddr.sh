#!/bin/bash

# User
user=$USER

# Get current date and time
current_date=$(date +"%Y-%m-%d")
current_time=$(date +"%H:%M:%S")

# Get system information
hostname=$(hostname)

# Perform curl command and check for errors
public_ip=$(curl -s https://api.ipify.org/ | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b')

# Check if the public IP is empty (indicating an error)
if [ -z "$public_ip" ]; then
  public_ip="Error retrieving public IP"
fi

lan_ip=$(hostname -I)
traceroute=$(mtr -n --json 8.8.8.8 | tr "\n" " " | sed 's/ \+ / /g')

# JSON output with separate fields for date, time, and user
printf '{"user":"%s", "date":"%s", "time":"%s", "hostname":"%s", "public_ip":"%s", "system_main_ip":"%s", "traceroute":%s}\n' \
  "$user" "$current_date" "$current_time" "$hostname" "$public_ip" "$system_main_ip" "$traceroute"
