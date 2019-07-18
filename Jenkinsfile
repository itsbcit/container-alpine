checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '6be5f607-a701-4a64-9097-c77c3f4cde24', url: env.GIT_URL]]])

stage('Template') {
    sh '''
        rake update
    '''
}

stage('Build') {
    sh '''
        rake build
    '''
}

stage('Test') {
    sh '''
        rake test
    '''
}
