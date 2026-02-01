pipeline {
    agent any

    environment {
        DEV_IMAGE  = "lakshmisrinath/dev:latest"
        PROD_IMAGE = "lakshmisrinath/prod:latest"
    }

    stages {
        stage('Build & Push') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {

                        if (env.BRANCH_NAME == 'dev') {
                            sh "./build.sh ${DEV_IMAGE}"
                            sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                            sh "docker push ${DEV_IMAGE}"
                        }

                        if (env.BRANCH_NAME == 'master') {
                            sh "./build.sh ${PROD_IMAGE}"
                            sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                            sh "docker push ${PROD_IMAGE}"
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                branch 'master'
            }
            steps {
                sh "./deploy.sh ${PROD_IMAGE}"
            }
        }
    }
}
