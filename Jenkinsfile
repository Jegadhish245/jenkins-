pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "jegadhish24/jenkins-node-app:latest"
        DOCKER_HUB_CREDENTIALS = "docker-hub-credentials" // Set this in Jenkins Credentials
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
                    docker.build(DOCKER_IMAGE)
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }
        stage('Run from Docker Hub') {
            steps {
                script {
                    sh "docker run -d --rm --name my_app_container -p 3000:3000 ${DOCKER_IMAGE}"
                }
            }
        }
    }
    post {
        always {
            script {
                sh "docker rm -f my_app_container || true"
                sh "docker rmi ${DOCKER_IMAGE} || true"
            }
        }
    }
}
