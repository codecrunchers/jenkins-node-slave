FROM node:6
ENV SECRET=""
ENV JENKINS_HOST="http://localhost:8080"
ENV SLAVE_NAME="slave"
ENV JDK="jdk-8u131-linux-x64"
WORKDIR /home/node/

RUN apt -y update && \
    mkdir -p jenkins_agent && \
    wget --quiet -c --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/$JDK.tar.gz && \
    mkdir java && \
    mkdir work && chmod 777 work && \
    tar xf $JDK.tar.gz -C java --strip-components 1 && \
    rm /home/node/$JDK.tar.gz

USER node
COPY slave.jar /home/node/jenkins_agent/slave.jar
COPY entrypoint.sh /home/node
ENTRYPOINT ["/home/node/entrypoint.sh"]




