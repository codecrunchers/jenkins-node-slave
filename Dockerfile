FROM node:6
ENV JDK "jdk-8u131-linux-x64"
ENV REMOTING_VERSION "3.9"
ENV TERRAFORM_VERSION 0.9.11
ENV SONAR_SCANNER_VERSION 2.8
ENV SONAR_SCANNER_HOME /home/sonar-scanner-${SONAR_SCANNER_VERSION}
ENV SONAR_SCANNER_PACKAGE sonar-scanner-${SONAR_SCANNER_VERSION}.zip
ENV SONAR_RUNNER_HOME ${SONAR_SCANNER_HOME}



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
        rm /tmp/${JDK}.tar.gz && \
        apt-get install -yqq --no-install-recommends python python-dev python-pip unzip bzip2 && \
        pip install awscli && \
        npm install -g pac nexus-deployer && \
        cd /tmp && wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
        unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
        cp terraform /usr/bin/terraform && \
        npm install -g gulp bower && \
        npm cache clean && \
        apt-get -yqq autoremove && \
        apt-get -yqq clean && \
        rm -rf /var/lib/apt/lists/* /var/cache/* /tmp/* /var/tmp/*


# Allow root for bower
RUN echo '{ "allow_root": true }' > /root/.bowerrc

RUN curl --insecure -OL https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/${SONAR_SCANNER_PACKAGE} && \
      unzip ${SONAR_SCANNER_PACKAGE} -d /home && \
      rm ${SONAR_SCANNER_PACKAGE}


RUN mkdir work && \
        chmod 755 /home/node/work && \
        chown node /home/node/work -R && \
        curl --create-dirs -sSLo /home/node/jenkins_agent/slave.jar \
        https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${REMOTING_VERSION}/remoting-${REMOTING_VERSION}.jar && \
        chmod 644 /home/node/jenkins_agent/slave.jar && \
        chown node /home/node/jenkins_agent -R

ENV PATH $PATH:${SONAR_SCANNER_HOME}/bin
USER node
ENTRYPOINT ["/home/node/java/bin/java", "-cp", "/home/node/jenkins_agent/slave.jar", "hudson.remoting.jnlp.Main","-headless"]
CMD ["--help"]
#ENTRYPOINT ["/bin/sh"]




