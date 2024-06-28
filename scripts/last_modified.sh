#!/bin/bash

# Directory to check
LOG_DIR="/var/log"

# Get current date
CURRENT_DATE=$(date +%Y-%m-%d)

# List last 3 modified files
ls -lt ${LOG_DIR} | head -n 4 | tail -n 3 > mod-${CURRENT_DATE}.out

# List files changed within last 5 days
find ${LOG_DIR}/* -mtime -5 > last_five-${CURRENT_DATE}.out

# Print 15-minute load average
awk '{print $3}' /proc/loadavg > loadavg-${CURRENT_DATE}.out
