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
  }
}
