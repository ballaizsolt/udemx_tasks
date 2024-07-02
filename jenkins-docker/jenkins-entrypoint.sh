#!/bin/bash

# Add jenkins user to the docker group
sudo usermod -aG docker jenkins

# Ensure Jenkins can access Docker socket
sudo chown jenkins:docker /var/run/docker.sock

# Start Jenkins
exec /usr/local/bin/jenkins.sh "$@"
