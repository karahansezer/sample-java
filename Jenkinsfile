pipeline {
    agent any
    environment {
        DOCKER_CREDENTIAL_ID = 'dockerhub'
        DOCKERHUB_REPO = 'karahansezer/sample-java'
        DOCKERHUB_TAG = 'latest'
    }
    tools {
        maven 'M3'
        dockerTool 'Docker' // specify the Docker installation here
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
        stage('Build Docker image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKERHUB_REPO}:${DOCKERHUB_TAG}")
                }
            }
        }
        stage('Push Docker image to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIAL_ID) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
