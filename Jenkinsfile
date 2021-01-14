pipeline {
    agent any
    stage('Test') {
        steps {
            echo 'testing...'
            sh 'pkgcheck scan'
            echo '...testing done?'
        }
    }
}
