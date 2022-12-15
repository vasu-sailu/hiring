pipeline {
    agent any

    stages {
        stage('git checkout') {
            steps {
               git branch: 'main', credentialsId: 'git-credentials', url: 'https://github.com/vasu-sailu/hiring' 
            }
        }
        stage('maven build') {
            steps {
               sh "mvn clean package" 
            }
        }
        
        
        stage('tomcat deploy') {
            steps {
               sshagent(['tomcat-creds']) {
                sh "scp -o StrictHostKeyChecking=no target/*.war ec2-user@172.31.7.187:/opt/tomcat9/webapps"
                sh "ssh ec2-user@172.31.7.187 /opt/tomcat9/bin/shutdown.sh"
                sh "ssh ec2-user@172.31.7.187 /opt/tomcat9/bin/startup.sh"
            }
        }
    }
}
}
