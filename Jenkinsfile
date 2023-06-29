pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    command:
    - /busybox/cat
    tty: true
"""
        }
    }
    environment {
        DOCKER_CREDENTIAL_ID = 'dockerhub'
        DOCKERHUB_REPO = 'karahansezer/sample-java'
        DOCKERHUB_TAG = 'latest'
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
        stage('Build and Push Docker image') {
            steps {
                container('kaniko') {
                    // Add your DockerHub credentials to the .docker/config.json file
                    sh '''
                        mkdir -p /home/jenkins/.docker/
                        echo "{\"auths\":{\"https://index.docker.io/v1/\":{\"auth\":\"`echo -n 'karahansezer:REtiVqR*52' | base64`\"}}}" > /home/jenkins/.docker/config.json
                    '''
                    // Build and push the Docker image using Kaniko
                    sh '''
                        /kaniko/executor --context=${WORKSPACE} --dockerfile=${WORKSPACE}/Dockerfile --destination=${DOCKERHUB_REPO}:${DOCKERHUB_TAG}
                    '''
                }
            }
        }
    }
}
