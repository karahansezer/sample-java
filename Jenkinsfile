pipeline {
    environment {
        DOCKER_CREDENTIAL_ID = 'dockerhub'
        DOCKERHUB_REPO = 'karahansezer/sample-java'
        DOCKERHUB_TAG = 'latest'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Maven build') {
            agent {
                docker {
                    image 'maven:3-openjdk-11'  // Assuming the maven image has JDK and Maven installed
                    args '-v $HOME/.m2:/root/.m2'  // Mount the Maven local repository
                }
            }
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Build Docker image') {
            agent {
                docker {
                    image 'docker:stable'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                script {
                    sh 'docker build -t $DOCKERHUB_REPO:$DOCKERHUB_TAG .'
                }
            }
        }
        stage('Push Docker image to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIAL_ID, usernameVariable: 'karahansezer', passwordVariable: 'REtiVqR*52')]) {
                        sh "docker login -u karahansezer -p REtiVqR*52"
                        sh "docker push $DOCKERHUB_REPO:$DOCKERHUB_TAG"
                    }
                }
            }
        }
    }
}
