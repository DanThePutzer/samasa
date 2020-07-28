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
            dockerfile {
                filename 'Dockerfile'
                registryUrl 'https://myregistry.com/'
                registryCredentialsId 'dockerHub'
            }
            steps {

            }
        }
    }
}