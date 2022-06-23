pipeline {

    agent {
        label "dev-a"
    }
    
    stages {

        stage('Build') {
            steps{
                // sh 'npm install'
                sh 'npm run build'
            }
        }

    }
}