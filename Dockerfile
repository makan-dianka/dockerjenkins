FROM jenkins/jenkins:lts-jdk17

USER root

RUN apt-get update && apt-get install wget -y && apt-get install xvfb -y
RUN apt-get install -y fontconfig && apt-get install -y openjdk-17-jre

RUN wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
RUN echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list > /dev/null


RUN apt-get update && apt-get install jenkins -y


# installation of nodejs 
RUN apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs


RUN node -v

USER jenkins
