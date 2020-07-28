node {
    def image
    def registry = 'danceladus/samasa'

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
        image = docker.build("<image name>")
    }

    stage('Push') {
        docker.withRegistry(registry, 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}