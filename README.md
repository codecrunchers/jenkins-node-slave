# jenkins-node-slave
Node Build Slave for Jenkins over jnlp. Provides node:6 tooling for building npm, javascript, grunt etc..

## Environment Vars
* JDK which JDK to install from Oracle
* REMOTING_VERSION for Jenkins slave JAR download

## Run

`docker run --env codecrunchers/jenkins-node-slave -headless "-url","http://jekins_ip:8080","<sceret>","<slave_name>"`


## Work Dir

Use `/home/node/work`

## Works well with 
[Jenkins Amazon ECS  amazon-ecs  plugin] (https://wiki.jenkins.io/display/JENKINS/Amazon+EC2+Container+Service+Plugin)
