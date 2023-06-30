pipeline {
  agent {
    kubernetes {
      yamlFile 'kaniko-builder.yaml'
    }
  }

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
        container('kaniko') {
          sh 'ls -la /kaniko'  // Add this line to list all files in the /kaniko directory
          sh "./executor --dockerfile ${WORKSPACE}/Dockerfile --context ${WORKSPACE} --destination=${DOCKER_USER}/${APP_NAME}:latest"
        }
      }
    }
  }
}
