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
                sh "docker tag goweb gcr.io/core-1-190918/goweb:latest"
                withCredentials([file(credentialsId: '727b9409-c3e0-46dc-9d38-33899e9b91fc', variable: 'keyfile')]) {
                  sh "docker login -u _json_key -p "$(cat ${keyfile})" https://gcr.io"
                  sh "docker push gcr.io/core-1-190918/goweb:latest"
                }
            }
        }
    }
  }
}