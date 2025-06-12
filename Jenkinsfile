pipeline {
    agent any
    environment {
        dockerfiles_path = 'docker/'
        docker_repo = '360871920119.dkr.ecr.us-east-1.amazonaws.com/'
        imagename = 'events-api'
        tag = 'latest'
        eventsapp_repo = 'https://github.com/msutton150/eventsappstart.git'
        eventsapp_path = "$imagename/"
        ecr_credentials_id = 'ecr:us-east-1:7b73aca7-fd7f-404e-9ff5-4ba215229bdd'

        dockerImage = ''
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                echo "${dockerfiles_path}${imagename}.dockerfile"
                dir('eventsapp') {
                    checkout scm: scmGit(branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: eventsapp_repo]])
                }
                script {
                    dockerImage = docker.build("${docker_repo}${imagename}:${tag}", "-f ${dockerfiles_path}${imagename}.dockerfile eventsapp/$eventsapp_path")
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Push') {
            steps {
                echo 'Pushing..'
                docker.withRegistry(url: docker_repo, credentialsId: ecr_credentials_id) {
                    echo "Pushing image ${dockerImage.imageName}"
                    // Push the Docker image to the ECR repository
                    script {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}