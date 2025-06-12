pipeline {
    agent any
    environment {
        dockerfiles_path = 'docker/'
        repo = '360871920119.dkr.ecr.us-east-1.amazonaws.com/'
        imagename = 'events-api'
        tag = 'latest'
        dockerImage = ''
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                echo "${dockerfiles_path}${imagename}.dockerfile"
                script {
                    dockerImage = docker.build("${repo}${imagename}:${tag}", "-f ${dockerfiles_path}${imagename}.dockerfile .")
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