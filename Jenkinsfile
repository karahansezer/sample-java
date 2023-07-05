pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: docker:latest
    command:
    - cat
    tty: true
    volumeMounts:
    - mountPath: /var/run/docker.sock
      name: docker-sock
  volumes:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock
'''
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
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Build Docker image') {
            steps {
                container('docker') {
                    sh 'docker build -t docker.io/karahansezer/sample-java:latest .'
                }
            }
        }

        stage('Login Docker') {
            steps {
                container('docker') {
                    sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                }
            }
        }

        stage('Push Images to DockerHub') {
            steps {
                container('docker') {
                    sh 'docker push docker.io/karahansezer/sample-java:latest'
                }
            }
        }
    }
    post {
        always {
            container('docker') {
                sh 'docker logout'
            }
        }
    }
    environment {
        DOCKER_USER = 'karahansezer'
        DOCKER_PASS = 'REtiVqR*52'
    }
}
