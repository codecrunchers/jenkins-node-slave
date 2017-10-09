# jenkins-node-slave
Node Build Slave for Jenkins over jnlp. Provides node:6 tooling for building npm, javascript, grunt etc..

## Environment Vars
* JDK which JDK to install from Oracle
* REMOTING_VERSION for Jenkins slave JAR download

## Ru

`docker run --env codecrunchers/jenkins-node-slave ["-url","http://jeknis_ip:8080","cee5fec7519379f67f77b03e0d036e151d596cc211e87279bc55c693a0756b92","ecs-8cc9807b0f4e"]

## Work Dir
Use `/home/node/work`
