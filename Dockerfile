FROM jenkins/jenkins:lts-jdk17

USER root


RUN apt update && apt install wget -y && apt install xvfb -y
RUN apt install -y fontconfig && apt install -y openjdk-17-jre

RUN wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
RUN echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list > /dev/null


RUN apt update && apt install jenkins -y

USER jenkins
