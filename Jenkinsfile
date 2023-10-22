pipeline {
    agent {
        label 'local1'
    }
    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }
        stage('Check Commit Message') {
            steps {
                script {
                    def commitMessage = sh(script: 'git log --format=%B -n 1', returnStatus: true)
                    def jiraPattern = ~/^([A-Z]+-\d+)\s+: .*/
                    if (commitMessage != 0) {
                        echo("Warning: No commit message found.")
                    } else if (!(sh(script: 'git log --format=%B -n 1 | grep -q "${jiraPattern}" && echo "true" || echo "false"', returnStatus: true) == 0)) {
                        echo("Warning: Commit message does not start with a Jira code.")
                    }
                }
            }
        }
        stage('Lint Dockerfiles') {
            steps {
                script {
                    // Define the Dockerfile paths
                    def dockerfilePaths = sh(script: 'find . -name Dockerfile', returnStdout: true).trim().split('\n')

                    if (dockerfilePaths) {
                        for (def dockerfilePath in dockerfilePaths) {
                            // Run hadolint on each Dockerfile
                            sh "hadolint ${dockerfilePath}"
                        }
                    } else {
                        echo "No Dockerfiles found."
                    }
                }
            }
        }
        stage('Check for Feature Branches') {
            steps {
                script {
                    def branches = checkout([$class: 'GitSCM', branches: [[name: '*/feature']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/HarrierPanels/Jenkins']])

                    if (branches.size() > 0) {
                        echo('Warning: Merging feature branch into master is not allowed! Please use branch protection rules in your version control system to enforce this policy.')
                    }
                }
            }
        }
    }
}
