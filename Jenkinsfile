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
            image: gcr.io/kaniko-project/executor:latest
            args: ["--dockerfile=Dockerfile",
                   "--context=dir://",
                   "--destination=core-1-190918/goweb:latest"]
            command:
            - cat
            tty: true
      """
    }
  }
  options { timestamps() }

  stages {
    stage('Build') {
        steps {
            container('docker') {
                echo "building"
            }
        }
    }
  }
}