node {
    def image
    def registry = 'danceladus/samasa'
    checkout scm

    stage('Setup') {
        sh 'pip install -r requirements.txt'
    }

    stage('Lint') {
        sh '''echo "- - Linting Resources - -"
            hadolint Dockerfile
            which pip
            pylint --disable=R,C,W1203 app.py'''
    }

    stage('Build') {
        image = docker.build(registry)
    }

    stage('Push') {
        docker.withRegistry('', 'dockerhub') {
            image.push()
        }
    }

    stage('Deploy') {
        withAWS(credentials:'aws') {
            sh 'aws eks --region us-west-2 update-kubeconfig --name SamasaCluster'
            sh 'kubectl get svc'
            sh 'kubectl apply -f deployment/samasa-blue.yml'
            sh 'kubectl apply -f deployment/samasa-green.yml'
            sh 'kubectl get deployments'
            sh 'kubectl apply -f deployment/load-balancer-blue.yml'
        }
    }

    stage('Approval') {
        input "Switch to green branch?"
    }

    stage('Switch') {
        withAWS(credentials:'aws') {
            sh 'kubectl apply -f deployment/load-balancer-green.yml'
        }
    }
}