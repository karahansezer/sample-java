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
      script {
        "/kaniko/executor --dockerfile ${WORKSPACE}/Dockerfile --context ${WORKSPACE} --destination=karahansezer/sample-java:latest --destination=karahansezer/sample-java:latest".execute()
      }
    }
  }
}
}
