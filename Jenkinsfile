pipeline {
    agent any
    
    stages {
        // stage('Build Docker Images') {
        //     steps {
        //         script {
        //             // Construire les images Docker avec docker-compose build
        //             bat 'docker-compose build'
        //         }
        //     }
        // }
        stage('Start Containers') {
            steps {
                script {
                    // Démarrer les conteneurs avec docker-compose up
                    bat 'docker-compose up -d --build' // L'option -d est utilisée pour exécuter en arrière-plan
                }
            }
        }
    }
    post {
        always {
            // Arrêter les conteneurs avec docker-compose down
           // bat 'docker-compose down'
            // Envoyer une notification a
            slackSend channel: 'devops', color: 'good', message: "Build and deployment completed successfully!"
        }
        failure {
            // Envoyer une notification Slack en cas d'échec
            slackSend channel: 'devops', color: 'danger', message: "Build or deployment failed!"
        }
    }
}
