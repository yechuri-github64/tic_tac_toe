pipeline {
    agent any
    
    environment {
       NAME = "tic_tac_toe"
       IMAGE_REPO = "akhilyechuri064"
       VERSION = "${env.BUILD_ID}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/yechuri-github64/tic_tac_toe'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${NAME} ."
                    sh "docker tag ${NAME}:latest ${IMAGE_REPO}/${NAME}:${VERSION}"                
                }
            }
        }
        stage('Pushing Image to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerpasswd', usernameVariable: 'dockerusername')]) {
                        sh 'echo ${dockerpasswd} | docker login -u ${dockerusername} --password-stdin'
                    }
                    sh "docker push ${IMAGE_REPO}/${NAME}:${VERSION}"
                }
            }
        }
        stage('Update Kubernetes Manifest') {
            steps {
                script {
                    sh "sed -i 's|image: ${IMAGE_REPO}/${NAME}:.*|image: ${IMAGE_REPO}/${NAME}:${VERSION}|' k8s/deployment.yaml"
                    sh "git add k8s/deployment.yaml"
                    sh "cat k8s/deployment.yaml"
                }
            }
        }
        stage('pushing to git'){
            steps {
                script {
                    sh 'git add k8s/deployment.yaml'
                    sh 'git commit -m "Updated deployment image tag to ${VERSION}"'
                    withCredentials([usernamePassword(credentialsId: 'git-id', passwordVariable: 'PW', usernameVariable: 'USER')]) {
                      sh 'git push https://${USER}:${PW}@github.com/yechuri-github64/tic_tac_toe.git main'
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline completed!'
        }
        success {
            echo 'Build and Docker image push were successful!'
        }
        failure {
            echo 'Build or Docker image push failed. Please check the logs!'
        }
    }
}
