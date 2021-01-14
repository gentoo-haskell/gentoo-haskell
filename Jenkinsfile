pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                sh 'pkgcheck scan'
                sh 'repoman full -dx'
            }
        }
    }
}
