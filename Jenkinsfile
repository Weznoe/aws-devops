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
                dir('eventsapp') {
                    checkout scm: scmGit(branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: eventsapp_repo]])
                }
                script {
                    dockerImage = docker.build("${docker_repo}${imagename}:${tag}", "-f ${dockerfiles_path}${imagename}.dockerfile eventsapp/")
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