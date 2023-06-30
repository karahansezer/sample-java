pipeline {
  agent any // If no specific agent is required you can use 'any'
  environment {
    APP_NAME = "sample-java"
    DOCKER_USER = "karahansezer"
    DOCKER_PASS = 'dockerhub'
    IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
    IMAGE_TAG = "latest"
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

    stage('Build & Push with Kaniko') {
      steps {
        container('kaniko') { // here, 'kaniko' should be replaced with the name you gave to the Kaniko container in Jenkins UI
          sh 'ls -la /kaniko'  
          sh "./executor --dockerfile ${WORKSPACE}/Dockerfile --context ${WORKSPACE} --destination=${DOCKER_USER}/${APP_NAME}:latest"
        }
      }
    }
  }
}
