pipeline {
    agent any
    environment {
        IMAGE = 'jegadhish24/jenkins-node-app:latest'
        DOCKER_HUB_CREDENTIALS = "docker-hub-crds"
        DOCKER_USER = "jegadhish24"
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $IMAGE ."
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: env.DOCKER_HUB_CREDENTIALS) {
                    script {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                        sh "docker push $IMAGE"
                        sh "docker logout"
                    }
                }
            }
        }
        stage('Run from Docker Hub') {
            steps {
                script {
                    sh "docker run -d --rm --name my_app_container -p 3000:3000 $IMAGE"
                }
            }
        }
    }
    post {
        always {
            script {
                sh "docker rm -f my_app_container || true"
                sh "docker rmi $IMAGE || true"
            }
        }
    }
}
