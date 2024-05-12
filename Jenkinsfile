pipeline {
    agent any
    triggers {
        githubPush()
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/nazimgueye/fil_rouge.git'
            }
        }
        stage('Build Docker Images') {
            steps {
                script {
                    // Build des images Docker
                    sh 'docker-compose up -d'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Récupérer le fichier kubeconfig depuis les credentials de Jenkins
                    def kubeconfig = credentials('kube_config')

                    // Assurez-vous que le fichier kubeconfig existe
                    if (!fileExists(kubeconfig)) {
                        error "Le fichier kubeconfig n'existe pas à l'emplacement spécifié."
                    }

                    // Appliquer les ressources Kubernetes depuis le dossier 'kubernetes' en utilisant le fichier kubeconfig
                    dir('kubernetes') {
                        // Utilisez la commande kubectl apply avec l'option --kubeconfig pour spécifier le fichier kubeconfig
                        sh "kubectl apply -f . --kubeconfig=${kubeconfig}"
                    }
                }
            }
        }
        stage('Run Docker Compose') {
            steps {
                script {
                    // Lancement des conteneurs Docker avec Docker Compose
                    sh 'docker-compose up -d --build'
                }
            }
        }
    }
    post {
        success {
            // Arrêter les conteneurs Docker en cas de succès
            // script {
            //     bat 'docker-compose down -v'
            // }
            // Envoyer un message de réussite à Slack
            slackSend channel: '#projetdevops', message: 'Build réussi'
        }
        failure {
            // Envoyer un message d'échec à Slack
            slackSend channel: '#projetdevops', message: 'Build échoué'
        }
    }
}
