#    +--------------------- Dockerfile                     ----------------+    
#    +                                                                     +    
#    +            name         Role          Describtion                   +    
#    +          ----------------------------------------------             +    
#    +          Steph  ' Bug Hunter       '        -         '             +    
#    +          Makan  ' Bug Hunter       '        -         '             +    
#    +                 '                  '                  '             +    
#    +                 '                  '                  '             +    
#    +                                                                     +    
#    +---------------------------------------------------------------------+    
#                                                
#    >*____dockerfile_____>_____dockerfile______>_______dockerfile_________>*




FROM jenkins/jenkins:lts-jdk17

USER root
RUN apt update && apt install -y wget

RUN wget -qO- https://deb.nodesource.com/setup_20.x | bash -
RUN apt install -y nodejs

RUN mkdir -p /tmp/.X11-unix && chmod -R 1777 /tmp
RUN apt install -y xvfb

RUN apt install -y fontconfig && apt install -y openjdk-17-jre && apt install -y openjdk-17-jdk

RUN wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key
RUN echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

RUN apt update 
RUN apt install jenkins -y
RUN chown -R 1000:1000 /var/jenkins_home
USER jenkins
