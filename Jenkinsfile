agent {
  kubernetes {
    // Use the default pod template
    defaultContainer 'jnlp'
    // Specify additional containers
    yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    command:
    - cat
    tty: true
"""
  }
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
        script {
          sh '/kaniko/executor --context $WORKSPACE --dockerfile $WORKSPACE/Dockerfile --destination=docker.io/karahansezer/sample-java:latest'
        }
      }
    }
  }
}
}
