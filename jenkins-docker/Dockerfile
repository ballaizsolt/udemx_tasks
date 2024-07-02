FROM jenkins/jenkins:lts

USER root

# Install Docker
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Create the Docker group
RUN groupadd docker

# Copy the entry script
COPY jenkins-entrypoint.sh /usr/local/bin/jenkins-entrypoint.sh

# Make the entry script executable
RUN chmod +x /usr/local/bin/jenkins-entrypoint.sh

USER jenkins

# Set the entrypoint to the script
ENTRYPOINT ["/usr/local/bin/jenkins-entrypoint.sh"]
