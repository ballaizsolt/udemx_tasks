#!/bin/bash

# NGINX default configuration file
NGINX_CONFIG="/etc/nginx/sites-available/default"

# Replace <title>Welcome to nginx!</title> with Title:
sed -i 's/<title>Welcome to nginx!<\/title>/Title: Welcome to nginx!<\/title>/' ${NGINX_CONFIG}

# Reload NGINX to apply changes
systemctl reload nginx
