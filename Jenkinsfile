pipeline {
  agent {
    kubernetes {
      cloud 'kubernetes'
      label 'mypod'
    }
  }
  stages {
    stage('Test') {
      steps {
        echo 'Hello, world!'
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
