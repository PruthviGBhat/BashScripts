#!/bin/bash

# Network Scanner Script

# Ask for the network IP range (e.g., 192.168.1.0/24)
echo "Enter your network IP range (e.g., 192.168.1.0/24):"
read IP_RANGE

# Use nmap to scan the network and list devices
echo "Scanning network... Please wait."
nmap -sP $IP_RANGE > scan_results.txt

# Display the scan results
echo "Scan results:"
cat scan_results.txt

# Optional: Filter results to show only devices with open ports
echo "Devices with open ports:"
nmap -sP $IP_RANGE | grep "Nmap scan report" | cut -d " " -f 