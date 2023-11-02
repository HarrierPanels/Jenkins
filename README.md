[![CICD](https://img.shields.io/badge/HarrierPanels-Multibranch%20Pipeline-blue)](./)
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
> [Pipeline] { (Test)<br>
> [Pipeline] sh<br>
> [guided-tour] Running shell script<br>
> \+ node --version<br>
> v16.13.1<br>
> [Pipeline] }<br>
> [Pipeline] // stage<br>
> [Pipeline] }
## 2. Put sensitive data in credentials (github connection details, etc)
```
pipeline {
    agent any
    environment {
        GITHUB_TOKEN = credentials('github-token')
    }
    stages {
        stage('Example') {
            steps {
                sh "echo $GITHUB_TOKEN"
                // Use the credential as needed
            }
        }
    }
}
```
## 3. Setting access rights. Create three groups (dev, qa, devops and grant different access rights)
```
[ec2-user@ip-192-168-0-145 ~]$ curl -u a:a http://192.168.0.145:8080/manage/role-strategy/assign-roles | grep 'b&gt;User&lt;/b&gt;:'
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
              </div></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: Dev &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: Anonymous &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[Dev]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: DevOps &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: Anonymous &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[DevOps]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: QA &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: Anonymous &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[QA]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: admin &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: Anonymous &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[admin]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td class="stop"></td></tr><tr name="[GROUP:authenticated]" class="highlight-row"><td class="start"></td><td class="left-most"><div title="authenticated" class="rsp-table__cell"><svg class="icon-sm" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 512 512"><path d="M402 168c-2.93 40.67-33.1 72-66 72s-63.12-31.32-66-72c-3-42.31 26.37-72 66-72s69 30.46 66 72z" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path d="M336 304c-65.17 0-127.84 32.37-143.54 95.41-2.08 8.34 3.15 16.59 11.72 16.59h263.65c8.57 0 13.77-8.25 11.72-16.59C463.85 335.36 401.18 304 336 304z" fill="none" stroke="currentColor" stroke-miterlimit="10" stroke-width="32"/><path d="M200 185.94c-2.34 32.48-26.72 58.06-53 58.06s-50.7-25.57-53-58.06C91.61 152.15 115.34 128 147 128s55.39 24.77 53 57.94z" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path d="M206 306c-18.05-8.27-37.93-11.45-59-11.45-52 0-102.1 25.85-114.65 76.2-1.65 6.66 2.53 13.25 9.37 13.25H154" fill="none" stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32"/></svg>
                                      </div></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: Dev &lt;br/&gt; &lt;b&gt;Group&lt;/b&gt;: authenticated &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[Dev]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: DevOps &lt;br/&gt; &lt;b&gt;Group&lt;/b&gt;: authenticated &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[DevOps]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: QA &lt;br/&gt; &lt;b&gt;Group&lt;/b&gt;: authenticated &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[QA]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: admin &lt;br/&gt; &lt;b&gt;Group&lt;/b&gt;: authenticated &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[admin]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td class="stop"></td></tr><tr name="[USER:a]" class="permission-row highlight-row" data-descriptor-url="/descriptor/com.michelin.cio.hudson.plugins.rolestrategy.RoleBasedAuthorizationStrategy"><td class="start"><div class="rsp-remove"><svg class="icon-sm icon-red rsp-table__icon" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 512 512"><title></title><path d="M112 112l20 320c.95 18.49 14.4 32 32 32h184c17.67 0 30.87-13.51 32-32l20-320" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32" d="M80 112h352"/><path d="M192 112V72h0a23.93 23.93 0 0124-24h80a23.93 23.93 0 0124 24h0v40M256 176v224M184 176l8 224M328 176l-8 224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/></svg></div></td><td class="left-most">a</td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: Dev &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: a &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[Dev]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: DevOps &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: a &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[DevOps]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: QA &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: a &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[QA]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: admin &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: a &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[admin]" checked="true" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td class="stop"><div class="rsp-table__cell"><div class="rsp-remove"><svg class="icon-sm icon-red rsp-table__icon" data-html-tooltip="&lt;b&gt;User&lt;/b&gt;: a" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 512 512"><title></title><path d="M112 112l20 320c.95 18.49 14.4 32 32 32h184c17.67 0 30.87-13.51 32-32l20-320" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32" d="M80 112h352"/><path d="M192 112V72h0a23.93 23.93 0 0124-24h80a23.93 23.93 0 0124 24h0v40M256 176v224M184 176l8 224M328 176l-8 224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/></svg></div></div></td></tr><tr name="[USER:dev]" class="permission-row highlight-row" data-descriptor-url="/descriptor/com.michelin.cio.hudson.plugins.rolestrategy.RoleBasedAuthorizationStrategy"><td class="start"><div class="rsp-remove"><svg class="icon-sm icon-red rsp-table__icon" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 512 512"><title></title><path d="M112 112l20 320c.95 18.49 14.4 32 32 32h184c17.67 0 30.87-13.51 32-32l20-320" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32" d="M80 112h352"/><path d="M192 112V72h0a23.93 23.93 0 0124-24h80a23.93 23.93 0 0124 24h0v40M256 176v224M184 176l8 224M328 176l-8 224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/></svg></div></td><td class="left-most">dev</td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: Dev &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: dev &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[Dev]" checked="true" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: DevOps &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: dev &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[DevOps]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: QA &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: dev &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[QA]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: admin &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: dev &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[admin]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td class="stop"><div class="rsp-table__cell"><div class="rsp-remove"><svg class="icon-sm icon-red rsp-table__icon" data-html-tooltip="&lt;b&gt;User&lt;/b&gt;: dev" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 512 512"><title></title><path d="M112 112l20 320c.95 18.49 14.4 32 32 32h184c17.67 0 30.87-13.51 32-32l20-320" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32" d="M80 112h352"/><path d="M192 112V72h0a23.93 23.93 0 0124-24h80a23.93 23.93 0 0124 24h0v40M256 176v224M184 176l8 224M328 176l-8 224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/></svg></div></div></td></tr><tr name="[USER:devops]" class="permission-row highlight-row" data-descriptor-url="/descriptor/com.michelin.cio.hudson.plugins.rolestrategy.RoleBasedAuthorizationStrategy"><td class="start"><div class="rsp-remove"><svg class="icon-sm icon-red rsp-table__icon" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 512 512"><title></title><path d="M112 112l20 320c.95 18.49 14.4 32 32 32h184c17.67 0 30.87-13.51 32-32l20-320" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32" d="M80 112h352"/><path d="M192 112V72h0a23.93 23.93 0 0124-24h80a23.93 23.93 0 0124 24h0v40M256 176v224M184 176l8 224M328 176l-8 224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/></svg></div></td><td class="left-most">devops</td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: Dev &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: devops &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[Dev]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: DevOps &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: devops &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[DevOps]" checked="true" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: QA &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: devops &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[QA]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: admin &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: devops &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[admin]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td class="stop"><div class="rsp-table__cell"><div class="rsp-remove"><svg class="icon-sm icon-red rsp-table__icon" data-html-tooltip="&lt;b&gt;User&lt;/b&gt;: devops" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 512 512"><title></title><path d="M112 112l20 320c.95 18.49 14.4 32 32 32h184c17.67 0 30.87-13.51 32-32l20-320" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32" d="M80 112h352"/><path d="M192 112V72h0a23.93 23.93 0 0124-24h80a23.93 23.93 0 0124 24h0v40M256 176v224M184 176l8 224M328 176l-8 224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/></svg></div></div></td></tr><tr name="[USER:qa]" class="permission-row highlight-row" data-descriptor-url="/descriptor/com.michelin.cio.hudson.plugins.rolestrategy.RoleBasedAuthorizationStrategy"><td class="start"><div class="rsp-remove"><svg class="icon-sm icon-red rsp-table__icon" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 512 512"><title></title><path d="M112 112l20 320c.95 18.49 14.4 32 32 32h184c17.67 0 30.87-13.51 32-32l20-320" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32" d="M80 112h352"/><path d="M192 112V72h0a23.93 23.93 0 0124-24h80a23.93 23.93 0 0124 24h0v40M256 176v224M184 176l8 224M328 176l-8 224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/></svg></div></td><td class="left-most">qa</td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: Dev &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: qa &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[Dev]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: DevOps &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: qa &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[DevOps]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: QA &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: qa &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[QA]" checked="true" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: admin &lt;br/&gt; &lt;b&gt;User&lt;/b&gt;: qa &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[admin]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td class="stop"><div class="rsp-table__cell"><div class="rsp-remove"><svg class="icon-sm icon-red rsp-table__icon" data-html-tooltip="&lt;b&gt;User&lt;/b&gt;: qa" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 512 512"><title></title><path d="M112 112l20 320c.95 18.49 14.4 32 32 32h184c17.67 0 30.87-13.51 32-32l20-320" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32" d="M80 112h352"/><path d="M192 112V72h0a23.93 23.93 0 0124-24h80a23.93 23.93 0 0124 24h0v40M256 176v224M184 176l8 224M328 176l-8 224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/></svg></div></div></td></tr></tbody><tfoot class="default-hidden"><tr class="group-row highlight-row"><td class="start"></td><td class="pane-header blank">User/group</td><td class="pane-header"><span>Dev</span></td><td class="pane-header"><span>DevOps</span></td><td class="pane-header"><span>QA</span></td><td class="pane-header"><span>admin</span></td><td class="stop"></td></tr></tfoot></table><template id="newGlobalRowTemplate"><tr class="permission-row highlight-row" data-descriptor-url="/descriptor/com.michelin.cio.hudson.plugins.rolestrategy.RoleBasedAuthorizationStrategy"><td class="start"><div class="rsp-remove"><svg class="icon-sm icon-red rsp-table__icon" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 512 512"><title></title><path d="M112 112l20 320c.95 18.49 14.4 32 32 32h184c17.67 0 30.87-13.51 32-32l20-320" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32" d="M80 112h352"/><path d="M192 112V72h0a23.93 23.93 0 0124-24h80a23.93 23.93 0 0124 24h0v40M256 176v224M184 176l8 224M328 176l-8 224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/></svg></div></td><td class="left-most">{{USER}}</td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: Dev &lt;br/&gt; &lt;b&gt;{{USERGROUP}}&lt;/b&gt;: {{USER}} &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[Dev]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: DevOps &lt;br/&gt; &lt;b&gt;{{USERGROUP}}&lt;/b&gt;: {{USER}} &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[DevOps]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: QA &lt;br/&gt; &lt;b&gt;{{USERGROUP}}&lt;/b&gt;: {{USER}} &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[QA]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td data-html-tooltip="&lt;b&gt;Role&lt;/b&gt;: admin &lt;br/&gt; &lt;b&gt;{{USERGROUP}}&lt;/b&gt;: {{USER}} &lt;br/&gt; " class="rsp-highlight-input"><span class="jenkins-checkbox"><input name="[admin]" type="checkbox" class="  "><label class="attach-previous js-checkbox-label-empty"></label></span></td><td class="stop"><div class="rsp-table__cell"><div class="rsp-remove"><svg class="icon-sm icon-red rsp-table__icon" data-html-tooltip="&lt;b&gt;{{USERGROUP}}&lt;/b&gt;: {{USER}}" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 512 512"><title></title><path d="M112 112l20 320c.95 18.49 14.4 32 32 32h184c17.67 0 30.87-13.51 32-32l20-320" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32" d="M80 112h352"/><path d="M192 112V72h0a23.93 23.93 0 0124-24h80a23.93 23.93 0 0124 24h0v40M256 176v224M184 176l8 224M328 176l-8 224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/></svg></div></div></td></tr></template><br><div class="jenkins-buttons-row jenkins-buttons-row--equal-width"><button data-empty-message="Please enter a user name" data-table-id="globalRoles" data-prompt="User name:" data-error-message="An entry for this user already exists" data-type="USER" type="button" data-highlighter="globalTableHighlighter" class="jenkins-button role-strategy-add-button" data-template-id="newGlobalRowTemplate">Add User</button><button data-empty-message="Please enter a group name" data-table-id="globalRoles" data-prompt="Group name:" data-error-message="An entry for this group already exists" data-type="GROUP" type="button" data-highlighter="globalTableHighlighter" class="jenkins-button role-strategy-add-button" data-template-id="newGlobalRowTemplate">Add Group</button></div></div></div><div class="row-set-end row-group-end tr jenkins-!-display-contents"></div></section><br><section class="jenkins-section"><div class="jenkins-section__title"><div class="jenkins-hidden"><?xml version="1.0" encoding="UTF-8"?>
100  117k    0  117k    0     0   503k      0 --:--:-- --:--:-- --:--:--  504k
```
```
import hudson.model.User
for (User user : User.getAll()) {
    println("Username: " + user.id)
}
```
#### Output:
> Username: dev<br>
> Username: devops<br>
> Username: qa
## Create a multibranch pipeline (branches master and feature), that is or doing:
1. Triggered by a change in any branch of the git repository, a separate pipeline is created for the branch
2. The pipeline consists of steps:
   a. Clone the repository from the feature branch
   b. Check the commit of the message for compliance with best practice (length of the message, first the Jira code of the ticket)
   c. Linting of Dockerfiles
3. For a pipeline file, block the option to merge feature branch into main.
#### The [Jenkinsfile](Jenkinsfile) includes four stages:
<sup>Clone Repository:</sup><br><br>Clones the repository from the current branch.<br><br> <sup>Check Commit Message:</sup><br><br>Checks the commit message for compliance with best practices.<br><br> <sup>Lint Dockerfiles:</sup><br><br>Lints the Dockerfiles using Hadolint.<br><br> <sup>Check for Feature Branches:</sup><br><br>Checks if there are any feature branches in the repository and prints a warning message if there are.<br><br>
#### Set Webhook:
```
[ec2-user@ip-192-168-0-145 ~]$ gh webhook forward \    
    --repo=HarrierPanels/my-java-project    \
    --events=push --url="http://localhost:8080/github-webhook/"
Forwarding Webhook events from GitHub...
```
```
Push event to branch master
22:27:53 Connecting to https://api.github.com using github-creds-user-token
Obtained Jenkinsfile from a1c0576053d1791a19257a79fb286854f3f851d3
[Pipeline] Start of Pipeline
[Pipeline] node
Running on local1 in /home/ec2-user/jenkins/workspace/Multibranch_master
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github-creds-user-token
Fetching changes from the remote Git repository
Fetching without tags
Checking out Revision a1c0576053d1791a19257a79fb286854f3f851d3 (master)
Commit message: "update 20"
 > git rev-parse --resolve-git-dir /home/ec2-user/jenkins/workspace/Multibranch_master/.git # timeout=10
 > git config remote.origin.url https://github.com/HarrierPanels/Jenkins.git # timeout=10
Fetching upstream changes from https://github.com/HarrierPanels/Jenkins.git
 > git --version # timeout=10
 > git --version # 'git version 2.40.1'
using GIT_ASKPASS to set credentials github-creds-user-token
 > git fetch --no-tags --force --progress -- https://github.com/HarrierPanels/Jenkins.git +refs/heads/master:refs/remotes/origin/master # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f a1c0576053d1791a19257a79fb286854f3f851d3 # timeout=10
 > git rev-list --no-walk 9c8382098522fecbbf96c050e66ddb4a0d070e51 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Clone Repository)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github-creds-user-token
Fetching changes from the remote Git repository
Fetching without tags
 > git rev-parse --resolve-git-dir /home/ec2-user/jenkins/workspace/Multibranch_master/.git # timeout=10
 > git config remote.origin.url https://github.com/HarrierPanels/Jenkins.git # timeout=10
Fetching upstream changes from https://github.com/HarrierPanels/Jenkins.git
 > git --version # timeout=10
 > git --version # 'git version 2.40.1'
using GIT_ASKPASS to set credentials github-creds-user-token
 > git fetch --no-tags --force --progress -- https://github.com/HarrierPanels/Jenkins.git +refs/heads/master:refs/remotes/origin/master # timeout=10
Checking out Revision a1c0576053d1791a19257a79fb286854f3f851d3 (master)
Commit message: "update 20"
 > git config core.sparsecheckout # timeout=10
 > git checkout -f a1c0576053d1791a19257a79fb286854f3f851d3 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Check Commit Message)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ git log --format=%B -n 1
update 20

[Pipeline] sh
+ git log --format=%B -n 1
+ grep -q ''
+ echo true
true
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Lint Dockerfiles)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ find . -name Dockerfile
[Pipeline] sh
+ hadolint ./Dockerfile
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Check for Feature Branches)
[Pipeline] script
[Pipeline] {
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
Fetching changes from the remote Git repository
Checking out Revision 60eeea963b277272837449b4282f30ea1d5b789c (refs/remotes/origin/feature)
Commit message: "update 19 feature"
 > git rev-parse --resolve-git-dir /home/ec2-user/jenkins/workspace/Multibranch_master/.git # timeout=10
 > git config remote.origin.url https://github.com/HarrierPanels/Jenkins # timeout=10
Fetching upstream changes from https://github.com/HarrierPanels/Jenkins
 > git --version # timeout=10
 > git --version # 'git version 2.40.1'
 > git fetch --tags --force --progress -- https://github.com/HarrierPanels/Jenkins +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/feature^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 60eeea963b277272837449b4282f30ea1d5b789c # timeout=10
 > git rev-list --no-walk 852ff763f3b360031040d507da5240c1ad2e1b5f # timeout=10
[Pipeline] echo
Warning: Merging feature branch into master is not allowed! Please use branch protection rules in your version control system to enforce this policy.
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline

GitHub has been notified of this commit’s build result

Finished: SUCCESS
```
```
Start of Pipeline - (12 sec in block)			
	
node - (7.4 sec in block)	local1		
node block - (7.3 sec in block)			
	
stage - (1.6 sec in block)	Declarative: Checkout SCM		
stage block (Declarative: Checkout SCM) - (1.5 sec in block)			
	
checkout - (1.5 sec in self)			
withEnv - (5.6 sec in block)	GIT_BRANCH, GIT_COMMIT, GIT_PREVIOUS_COMMIT, GIT_PREVIOUS_SUCCESSFUL_COMMIT, GIT_URL		
withEnv block - (5.5 sec in block)			
	
stage - (1.4 sec in block)	Clone Repository		
stage block (Clone Repository) - (1.3 sec in block)			
	
checkout - (1.2 sec in self)			
stage - (1.1 sec in block)	Check Commit Message		
stage block (Check Commit Message) - (1 sec in block)			
	
script - (0.95 sec in block)			
script block - (0.87 sec in block)			
	
sh - (0.46 sec in self)	git log --format=%B -n 1		
sh - (0.37 sec in self)	git log --format=%B -n 1 | grep -q "${jiraPattern}" && echo "true" || echo "false"		
stage - (1.2 sec in block)	Lint Dockerfiles		
stage block (Lint Dockerfiles) - (1.1 sec in block)			
	
script - (1 sec in block)			
script block - (0.84 sec in block)			
	
sh - (0.4 sec in self)	find . -name Dockerfile		
sh - (0.38 sec in self)	hadolint ./Dockerfile		
stage - (1.6 sec in block)	Check for Feature Branches		
stage block (Check for Feature Branches) - (1.5 sec in block)			
	
script - (1.4 sec in block)			
script block - (1.4 sec in block)			
	
checkout - (1.3 sec in self)			
echo - (16 ms in self)	Warning: Merging feature branch into master is not allowed! Please use branch protection rules in your version control system to enforce this policy.
```
```
Push event to branch feature
22:20:28 Connecting to https://api.github.com using github-creds-user-token
Obtained Jenkinsfile from 60eeea963b277272837449b4282f30ea1d5b789c
[Pipeline] Start of Pipeline
[Pipeline] node
Running on local1 in /home/ec2-user/jenkins/workspace/Multibranch_feature
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github-creds-user-token
Fetching changes from the remote Git repository
Fetching without tags
 > git rev-parse --resolve-git-dir /home/ec2-user/jenkins/workspace/Multibranch_feature/.git # timeout=10
 > git config remote.origin.url https://github.com/HarrierPanels/Jenkins.git # timeout=10
Fetching upstream changes from https://github.com/HarrierPanels/Jenkins.git
 > git --version # timeout=10
 > git --version # 'git version 2.40.1'
using GIT_ASKPASS to set credentials github-creds-user-token
 > git fetch --no-tags --force --progress -- https://github.com/HarrierPanels/Jenkins.git +refs/heads/feature:refs/remotes/origin/feature # timeout=10
Checking out Revision 60eeea963b277272837449b4282f30ea1d5b789c (feature)
Commit message: "update 19 feature"
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 60eeea963b277272837449b4282f30ea1d5b789c # timeout=10
 > git rev-list --no-walk 852ff763f3b360031040d507da5240c1ad2e1b5f # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Clone Repository)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github-creds-user-token
Fetching changes from the remote Git repository
Fetching without tags
Checking out Revision 60eeea963b277272837449b4282f30ea1d5b789c (feature)
Commit message: "update 19 feature"
 > git rev-parse --resolve-git-dir /home/ec2-user/jenkins/workspace/Multibranch_feature/.git # timeout=10
 > git config remote.origin.url https://github.com/HarrierPanels/Jenkins.git # timeout=10
Fetching upstream changes from https://github.com/HarrierPanels/Jenkins.git
 > git --version # timeout=10
 > git --version # 'git version 2.40.1'
using GIT_ASKPASS to set credentials github-creds-user-token
 > git fetch --no-tags --force --progress -- https://github.com/HarrierPanels/Jenkins.git +refs/heads/feature:refs/remotes/origin/feature # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 60eeea963b277272837449b4282f30ea1d5b789c # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Check Commit Message)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ git log --format=%B -n 1
update 19 feature

[Pipeline] sh
+ grep -q ''
+ git log --format=%B -n 1
+ echo true
true
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Lint Dockerfiles)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ find . -name Dockerfile
[Pipeline] sh
+ hadolint ./Dockerfile
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Check for Feature Branches)
[Pipeline] script
[Pipeline] {
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
Fetching changes from the remote Git repository
Checking out Revision 60eeea963b277272837449b4282f30ea1d5b789c (refs/remotes/origin/feature)
Commit message: "update 19 feature"
 > git rev-parse --resolve-git-dir /home/ec2-user/jenkins/workspace/Multibranch_feature/.git # timeout=10
 > git config remote.origin.url https://github.com/HarrierPanels/Jenkins # timeout=10
Fetching upstream changes from https://github.com/HarrierPanels/Jenkins
 > git --version # timeout=10
 > git --version # 'git version 2.40.1'
 > git fetch --tags --force --progress -- https://github.com/HarrierPanels/Jenkins +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/feature^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 60eeea963b277272837449b4282f30ea1d5b789c # timeout=10
[Pipeline] echo
Warning: Merging feature branch into master is not allowed! Please use branch protection rules in your version control system to enforce this policy.
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline

GitHub has been notified of this commit’s build result

Finished: SUCCESS
```
```
Start of Pipeline - (8.8 sec in block)			
	
node - (7.8 sec in block)	local1		
node block - (7.6 sec in block)			
	
stage - (2 sec in block)	Declarative: Checkout SCM		
stage block (Declarative: Checkout SCM) - (1.9 sec in block)			
	
checkout - (1.8 sec in self)			
withEnv - (5.4 sec in block)	GIT_BRANCH, GIT_COMMIT, GIT_PREVIOUS_COMMIT, GIT_PREVIOUS_SUCCESSFUL_COMMIT, GIT_URL		
withEnv block - (5.3 sec in block)			
	
stage - (1.3 sec in block)	Clone Repository		
stage block (Clone Repository) - (1.2 sec in block)			
	
checkout - (1.1 sec in self)			
stage - (1.1 sec in block)	Check Commit Message		
stage block (Check Commit Message) - (1 sec in block)			
	
script - (0.96 sec in block)			
script block - (0.87 sec in block)			
	
sh - (0.4 sec in self)	git log --format=%B -n 1		
sh - (0.42 sec in self)	git log --format=%B -n 1 | grep -q "${jiraPattern}" && echo "true" || echo "false"		
stage - (1.3 sec in block)	Lint Dockerfiles		
stage block (Lint Dockerfiles) - (1.2 sec in block)			
	
script - (1.1 sec in block)			
script block - (1.1 sec in block)			
	
sh - (0.47 sec in self)	find . -name Dockerfile		
sh - (0.38 sec in self)	hadolint ./Dockerfile		
stage - (1.4 sec in block)	Check for Feature Branches		
stage block (Check for Feature Branches) - (1.3 sec in block)			
	
script - (1.2 sec in block)			
script block - (1.2 sec in block)			
	
checkout - (1.1 sec in self)			
echo - (13 ms in self)	Warning: Merging feature branch into master is not allowed! Please use branch protection rules in your version control system to enforce this policy.
```
[See next](https://github.com/HarrierPanels/my-java-project)
