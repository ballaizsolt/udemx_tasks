#!/bin/bash

# Flush existing rules
iptables -F

# Set default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback interface
iptables -A INPUT -i lo -j ACCEPT

# Allow established and related connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RLEATED -j ACCEPT

# Allow SSH on port 2222
iptables -A INPUT tcp --dport 2222 -j ACCEPT

# Allow HTTP and HTTPS traffic
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
#for docker container --dport 8080
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
#for docker container --dport 8443

# Allow MariaDB
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
#for docker container --dport 3307

# Log and drop everything else
iptables -A INPUT -j LOG --log-prefix "iptables: "
iptables -A INPUT -j DROP

# Save iptables rules
iptables-save > /etc/iptables/rules.v4

# Enable iptables at boot
apt-get install iptables-presistent -y
systemctl enable netfilter-persistent
