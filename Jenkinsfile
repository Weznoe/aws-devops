pipeline {
    agent any
    parameters {
        string(name: 'dockerfiles_dir', defaultValue: 'docker/', description: "The directory where the Dockerfiles are located")
        string(name: 'docker_repo', defaultValue: 'https://360871920119.dkr.ecr.us-east-1.amazonaws.com/', description: "The Docker ECR URL for your account")
        string(name: 'eventsapp_repo', defaultValue: 'https://github.com/msutton150/eventsappstart.git', description: "The Git repository for the events-app source code")
        choice(name: 'image_name', choices: ['events-api', 'events-job', 'events-web'], description: "The name of which events-app service to build")
        credentials(name: 'ecr_credentials', description: "A user or role with permissions to push and pull from ECR", defaultValue: 'ecr:us-east-1:7b73aca7-fd7f-404e-9ff5-4ba215229bdd')
        string(name: 'tag', defaultValue: 'latest', description: "The tag to use for the Docker image")
    }
    environment { 
      eventsapp_path = "${params.image_name == "events-job" ? "database-initializer" : imagename}"
      dockerImage = ''
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                dir('eventsapp') {
                    checkout scm: scmGit(branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: params.eventsapp_repo]])
                }
                script {
                    dockerImage = docker.build("${params.image_name}:${params.tag}", "-f ${params.dockerfiles_dir}${params.image_name}.dockerfile eventsapp/$eventsapp_path")
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
                    docker.withRegistry(docker_repo, ecr_credentials_id) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}