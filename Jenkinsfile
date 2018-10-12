pipeline {
  agent {
    kubernetes {
      label 'gobuild'
      defaultContainer 'docker'
      yaml """
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: docker
            image: docker:18-dind
            tty: true
            securityContext:
              privileged: true
      """
    }
  }
  options { timestamps() }

  stages {
    stage('Build') {
        steps {
            container('docker') {
                sh "docker build -t goweb ."
                sh "docker push gcr.io/core-1-190918/goweb:latest"
            }
        }
    }
  }
}