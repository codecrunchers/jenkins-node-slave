#!/bin/bash
/home/node/java/bin/java -jar /home/node/jenkins_agent/slave.jar -jnlpUrl http://172.19.0.1:8080/computer/slave/slave-agent.jnlp -secret ba9268aaa171b722bbd7ee2e1be957dce02e0ab1059f9cd9e8b3b8d1ee71b2ab -workDir "/home/node/work"
exec "$@"


