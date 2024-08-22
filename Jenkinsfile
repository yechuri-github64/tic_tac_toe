pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/yechuri-github64/tic_tac_toe'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                   sh 'docker build -t akhilyechuri064/tic_tac_toe .'
                }
            }
        }
        stage('Pushing Image to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                        sh 'docker login -u akhilyechuri064 -p ${dockerhubpwd}'
                    }
                    sh 'docker tag akhilyechuri064/tic_tac_toe akhilyechuri064/tic_tac_toe:latest'
                    sh 'docker push akhilyechuri064/tic_tac_toe:latest'
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
