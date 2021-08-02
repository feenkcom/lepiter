pipeline {
    agent any
    stages {
        stage('Build gtoolkit') {
            when { expression {
                    env.BRANCH_NAME.toString().equals('main') && (env.TAG_NAME == null)
                }
            }
            steps {
                build(job: '../gtoolkit/main', wait: false)
            }
        }
    }
}
