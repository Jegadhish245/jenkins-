pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds'
        DOCKERHUB_USERNAME = 'your_dockerhub_username'
        IMAGE_NAME = 'your_dockerhub_username/jenkins-node-app'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', "${DOCKERHUB_CREDENTIALS}") {
                        docker.image("${IMAGE_NAME}:${IMAGE_TAG}").push()
                    }
                }
            }
        }
        stage('Run from Docker Hub') {
            steps {
                script {
                    sh """
                        docker pull ${IMAGE_NAME}:${IMAGE_TAG}
                        docker run -d --name my_app_container -p 8080:8080 ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }
    }
    post {
        always {
            sh """
                docker rm -f my_app_container || true
                docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true
            """
        }
    }
}
