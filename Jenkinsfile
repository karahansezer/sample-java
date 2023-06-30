pipeline {
    agent {
        kubernetes {
            label 'kaniko'
        }
    }

    tools {
        maven 'M3'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Maven build') {
            steps {
                withMaven() {
                    sh 'mvn clean install'
                }
            }
        }

        stage('Build and push') {
            steps {
                container('kaniko') {
                    sh '''
                    /kaniko/executor --context ${WORKSPACE} --dockerfile ${WORKSPACE}/Dockerfile --destination karahansezer/sample-java
                    '''
                }
            }
        }
    }
}
