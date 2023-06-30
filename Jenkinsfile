pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    command:
    - /bin/cat
    tty: true
    volumeMounts:
    - name: docker-config
      mountPath: /kaniko/.docker
  volumes:
  - name: docker-config
    secret:
      secretName: docker-config
"""
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
                    /kaniko/executor --context ${WORKSPACE} --dockerfile ${WORKSPACE}/Dockerfile --destination karahansezer/sample-java --docker-config /kaniko/.docker
                    '''
                }
            }
        }
    }
}
