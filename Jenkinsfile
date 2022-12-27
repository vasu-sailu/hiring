pipeline {
    agent any

    stages {
        
        stage('Maven Build') {
            steps {
                sh "mvn clean package"
            }
        }
        
        stage('Docker Build') {
            steps {
                sh "docker build . -t yennampallisailu/hiring:${commit_id()}"
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'hubpwd')]) {
                    sh "docker login -u yennampallisailu -p ${hubpwd}"
                    sh "docker push yennampallisailu/hiring:${commit_id()}"
                }
            }
        }
        stage('Docker Deploy') {
            steps {
                sshagent(['docker-host']) {
                    sh "ssh -o StrictHostKeyChecking=no  ec2-user@172.31.8.114 docker rm -f hiring"
                    sh "ssh  ec2-user@172.31.8.114 docker run -d -p 8080:8080 --name hiring yennampallisailu/hiring:${commit_id()}"
                }
            }
        }

    }
}

def commit_id(){
    id = sh returnStdout: true, script: 'git rev-parse HEAD'
    return id
}
