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
  - name: docker
    image: docker:dind
    securityContext:
      privileged: true
    volumeMounts:
    - mountPath: /var/run/docker.sock
      name: docker-sock
  volumes:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock
      type: File
"""
        }
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Maven build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Build and Push Docker image') {
            steps {
                container('docker') {
                    sh '''
                        docker build -t docker.io/karahansezer/sample-java:latest $WORKSPACE
                        docker login -u $DOCKER_USER -p $DOCKER_PASS
                        docker push docker.io/karahansezer/sample-java:latest
                    '''
                }
            }
        }
    }
    environment {
        DOCKER_USER = 'karahansezer'
        DOCKER_PASS = 'REtiVqR*52'
    }
}
