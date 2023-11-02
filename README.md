[![CICD](https://img.shields.io/badge/HarrierPanels-CI%2FCD-blue)](./)
[![EPAM](https://img.shields.io/badge/Cloud&DevOps%20UA%20Lab%202nd%20Path-Jenkins%20Task-orange)](./)
[![HitCount](https://hits.dwyl.com/HarrierPanels/my-java-project.svg?style=flat&show=unique)](http://hits.dwyl.com/HarrierPanels/my-java-project)
<br>

## 1. Configuring agents 1.1 static ) 1.2 dynamic (eg https://www.jenkins.io/doc/book/pipeline/docker/)

```
Jenkins.instance.nodes.each {
    println "Node: ${it.name}, Online: ${it.toComputer().online}, Label: ${it.labelString}"
}
```
#### Output:
> Node: local1, Online: true, Label: local1<br>
> Result: [hudson.slaves.DumbSlave[local1]]
#### Jenkinsfile (Declarative Pipeline):
```
pipeline {
    agent {
        docker { image 'node:18.18.2-alpine3.18' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
    }
}
```
#### Output:
> [Pipeline] stage<br>
[Pipeline] { (Test) <br>
[Pipeline] sh<br>
[guided-tour] Running shell script<br>
+ node --version<br>
v16.13.1<br>
[Pipeline] }<br>
[Pipeline] // stage<br>
[Pipeline] }
