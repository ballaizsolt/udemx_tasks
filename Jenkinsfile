pipeline {
    agent any

    environment {
        DOCKER_HUB = "docker.io"
        APP_IMAGE = "${DOCKER_HUB}/ballaizsolt/udemx_tasks"
    }

    stages {
        stage('Verify Docker') {
            steps {
                script {
                    sh 'docker --version'
                }
            }
        }
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '4077b360-426a-415c-b74a-6e24e002cedb', url: 'git@github.com:ballaizsolt/udemx_tasks.git']])
            }
        }

        stage('Build') {
            steps {
                script {
                    def app = docker.build("${APP_IMAGE}:${env.BUILD_ID}")
                    env.IMAGE_NAME = app.id
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    docker.withRegistry("https://${DOCKER_HUB}", 'ballaizsolt') {
                        docker.image(env.IMAGE_NAME).push('latest')
                        docker.image(env.IMAGE_NAME).push("${env.BUILD_ID}")
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'docker ps -q --filter "name=hello-world-app" | grep -q . && docker stop hello-world-app && docker rm hello-world-app || true'
                    docker.image("${APP_IMAGE}:latest").run("-d --name hello-world-app -p 8085:80")
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
