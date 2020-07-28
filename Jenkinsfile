pipeline {
    agent any
    environment {
        registry = 'danceladus/samasa'
    }
    stages {
        stage('Lint') {
            steps {
                sh '- - Linting Resources - -'
                sh 'hadolint Dockerfile'
                sh 'pylint --disable=R,C,W1203 app.py'
            }
        }
        
        stage('Build') {
            agent {
                dockerfile {
                    filename 'Dockerfile'
                    registryCredentialsId 'dockerHub'
                }
            }
        }
    }
}