# AWS Engagement Ready Program - DevOps Capstone
If you're reading this, I was super busy this week and had to allocate my time elsewhere. Got a pipeline done that can build each of the images, but nothing more. If I were to spend more time on this I would create a few more pipelines, driven by an orchestrator pipeline that:
1. Calls this build image pipeline for each app in eventsapp
1. Calls a pipeline to check if a k8s cluster exists and creates one if necessary
1. Calls a deploy pipeline for each helmfile

## Table of Contents

- [Objectives](#objectives)

- [Jenkins Server](#jenkins-server)

### Objectives
1. Stand up a Jenkins server
1. Create pipelines that:
    1. Build and push images for the apps
    1. Create a Kubernetes cluster
    1. Deploy built images into the cluster

### Jenkins Server
If you already have a suitable jenkins instance setup, simply create Pipeline that points at the Jenkinsfile in this repo.
If you want to demonstrate building on commit you'll need to fork this project, create a GitHub API token, and set up the connection in Jenkins.


##### Plugins
- all the defaults
- docker pipeline
- aws ecr
- aws credentials

##### Credentials
- create github API token
- create AWS IAM Role
    - add it as an AWS credential in Jenkins, with the ARN for the role as the only argument
