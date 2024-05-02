pipeline {
    agent any
    stages {
        stage ('test') {
            steps {
                powershell 'docker ps -a'
            }
        }
        stage ('Run Docker Compose') {
            steps {
                powershell 'docker-compose up -d'
            }
        }
    }
}
