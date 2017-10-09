FROM node:6
ENV JDK "jdk-8u131-linux-x64"
ENV REMOTING_VERSION "3.9"

WORKDIR /home/node/

RUN apt -y update && \
        mkdir -p /home/node/jenkins_agent && \
        chmod 755 /home/node/jenkins_agent && \
        wget --quiet -c --header "Cookie: oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/${JDK}.tar.gz -O /tmp/${JDK}.tar.gz && \
        mkdir /home/node/java && \
        chmod 755 /home/node/java && \
        chown node /home/node/java -R && \
        tar xf /tmp/${JDK}.tar.gz -C java --strip-components 1 && \
        rm /tmp/${JDK}.tar.gz

RUN mkdir work && \
        chmod 755 /home/node/work && \
        chown node /home/node/work -R && \
        curl --create-dirs -sSLo /home/node/jenkins_agent/slave.jar \
        https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${REMOTING_VERSION}/remoting-${REMOTING_VERSION}.jar && \
        chmod 644 /home/node/jenkins_agent/slave.jar && \
        chown node /home/node/jenkins_agent -R


USER node
ENTRYPOINT ["/home/node/java/bin/java", "-cp", "/home/node/jenkins_agent/slave.jar", "hudson.remoting.jnlp.Main","-headless"]
CMD ["--help"]
#ENTRYPOINT ["/bin/sh"]




