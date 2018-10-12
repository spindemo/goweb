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
                script {
                  if (env.BRANCH_NAME == 'master') {
                    withCredentials([file(credentialsId: 'gcr-agent', variable: 'keyfile')]) {
                      sh "cat ${keyfile} | docker login -u _json_key --password-stdin https://gcr.io"
                      sh "docker push gcr.io/core-1-190918/goweb:latest"
                    }
                  }
                }
            }
        }
    }
  }
}