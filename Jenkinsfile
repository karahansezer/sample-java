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
        container(name: 'kaniko', shell: '/busybox/sh') {
          sh '''#!/busybox/sh

            /kaniko/executor --dockerfile `pwd`/Dockerfile --context `pwd` --destination=${IMAGE_NAME}:${IMAGE_TAG} --destination=${IMAGE_NAME}:latest
          '''
        }
      }
    }
  }
}
