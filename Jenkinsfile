pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                echo 'testing...'
                sh 'pkgcheck scan'
                echo '...testing done?'
            }
        }
    }
}
