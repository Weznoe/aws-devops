pipeline {
    agent any
    environment {
        dockerfiles_path = 'docker/'
        docker_repo = '360871920119.dkr.ecr.us-east-1.amazonaws.com/'
        imagename = 'events-api'
        tag = 'latest'
        eventsapp_repo = 'https://github.com/msutton150/eventsappstart.git'
        eventsapp_path = 'eventsappstart/'


        dockerImage = ''


    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                echo "${dockerfiles_path}${imagename}.dockerfile"
                checkout eventsapp_repo
                sh 'ls'
                script {
                    dockerImage = docker.build("${docker_repo}${imagename}:${tag}", "-f ${dockerfiles_path}${imagename}.dockerfile eventsapp_path")
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
                script {
                    dockerImage.push()
                }
            }
        }
    }
}