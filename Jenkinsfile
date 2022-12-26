pipeline {
    agent any
 
    stages{
        
        stage('maven build') {
            steps {
               sh "mvn clean package" 
            }
        }
        
        stage('DOCKER BUILD') {
            steps {
               sh "docker build -t yennampallisailu/hiring:0.0.2 ."
            }
        }
        stage('DOCKER PUSH') {
            steps {
                 withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'hubpwd')]) {
                     sh "docker login -u yennampallisailu -p ${hubpwd}"
                     sh "docker push yennampallisailu/hiring:0.0.2"                   
                      } 
                 }
            }
        stage('DOCKER DEPLOY') {
            steps {
                 sshagent(['tomcat-creds']) {
                 sh "ssh ec2-user@172.31.8.114 docker run -d -p 8080:8080 --sailu hiring yennampallisailu/hiring:0.0.2"
                 }
             }
         }
     }
}
