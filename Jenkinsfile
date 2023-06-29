pipeline {
    agent any
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
        stage('Build Docker image') {
            steps {
                script {
                    dockerImage = docker.build("karahansezer/sample-java:latest")
                }
            }
        }
        stage('Push Docker image to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'karahansezer', passwordVariable: 'REtiVqR*52')]) {
                        docker.withRegistry('https://index.docker.io/v1/', "karahansezer:REtiVqR*52") {
                            dockerImage.push()
                        }
                    }
                }
            }
        }
    }
}
