# jenkins-node-slave
Node Build Slave for Jenkins over jnlp. Provides node:6 tooling for building npm, javascript, grunt etc..

## Environment Vars
* JENKINS_HOST 
* SLAVE_NAME
* SECRET

## Run

`docker run --env SLAVE_NAME="slave" --env JENKINS_HOST="http://172.19.0.1:8080" --env SECRET="ba9268aaa171b722bbd7ee2e1be957dce02e0ab1059f9cd9e8b3b8d1ee71b2ab"  codecrunchers/jenkins-node-slave`

## Work Dir
Use `/home/node/work`
