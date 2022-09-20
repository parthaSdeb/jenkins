FROM jenkins/jenkins

ARG HOST_JENKINS_UID=1001
ARG HOST_DOCKER_GID=998
User root

RUN apt update -y && apt-get install ca-certificates curl gnupg lsb-release -y && mkdir -p /etc/apt/keyrings && \
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && apt update -y && \
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

RUN usermod -u $HOST_JENKINS_UID jenkins
RUN groupmod -g $HOST_DOCKER_GID docker
RUN usermod -aG docker jenkins



USER jenkins
