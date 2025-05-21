# AWS Engagement Ready Program - Kubernetes Capstone
## Table of Contents

- [Objectives](#objectives)

- [Environment](#environment)

- [Containerize](#containerize)

- [Deploy Cluster](#deploy-cluster)
  
- [Blue/Green Update](#bluegreen-update)

- [Cleanup](#cleanup)

### Objectives
1. Create and configure your deployment environment
1. Containerize and store your images in a repository
1. Deploy an Amazon EKS cluster
1. Deploy your application, including a backend database
1. Test updating your application using rolling updates

### Environment
If you already have a suitable development instance setup, simply [download this repo](#download-this-repo).

##### Create an AWS access key pair
1. Login to the [AWS Management Console](https://console.aws.amazon.com/).
1. Navigate to the `IAM` service.
1. Select the `Users` link from the left.
1. Select your user.
1. Select the `Security Credentials` tab, then scroll down to `Access keys` and select `Create access key`.
1. Select the `CLI` use case and check the confirmation disclaimer at the bottom, then select `Next`.
1. Select `Create access key`.
1. Select `Download .csv file` and save this file for later.

#####  Create an EC2 Instance and connect to it
1. Navigate to the EC2 service.
1. Select the `Instances` link from the left.
1. Select `Launch Instances`.
1. In the `Name` field, enter a name for this instance (ex. `deploy-env`).
1. Choose Instance type of `t3.medium` or better.
1. Under the `Key pair (login)` select `Proceed without a key pair (Not recommended)`
1. Configure at least 20GiB of storage.
1. Leave the defaults for everything else.
1. Select `Launch Instance`.
1. Wait for the instance to launch, then navigate to the launched instance and select `Connect`.
1. In the `Connect to instance` screen, leave the defaults and select `Connect`.

##### Download this repo
1. `sudo yum install git -y`
1. `cd ~`
1. `git clone https://github.com/Weznoe/aws-kubernetes.git`

##### Install your environment tools
1. `cd ~/aws-kubernetes`
1. `./setup_environment.sh`
    1. Input the AWS Access Key and AWS Secret Access Key from the `.csv` file you downloaded earlier.
    1. Enter your region.
    1. Enter `json` for default output format.
    1. You may be prompted for a `sudo` password.

### Containerize
##### Download the sample app repo
1. `cd ~`
1. `git clone https://github.com/msutton150/eventsappstart.git`
##### Create your ECR repos to host your images
1. Navigate to the ECR service.
1. Select `Create Repository`.
1. Name the repo `events-api`. 
1. Accept the defaults for everything else.
1. Select `Create`.
1. Do the same for `events-website` and `events-job`.


1. Copy the URI of one of the repos, you just created.
1. On your `deploy-env` box, login to ECR through docker: 
```docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) <the repo uri you copied>```

##### Build and tag the images

1. `cd ~/aws-kubernetes/docker`
1. Run the build script, passing the  base URI of your ECR repos (like `<account-#>.dkr.ecr.<region>.amazonaws.com`) as an argument: 
```
./build_all.sh <base_uri> 
```
> NOTE: \
    - The `<base_uri>` should not end in a trailing `/`. \
    - The build script included in this repo expects the sample app code to live at `~/eventsappstart/` by default, but a different path can be passed as the second arg.


This will create and push v1.0 images for all three apps, a v2.0 image for events-website, and update the `.yaml` resource files with the correct images.

### Deploy Cluster

### Blue/Green Update

### Cleanup
When you're all done, clean up your VM you created in [Environment](#environment). 
1. Navigate to the EC2 service.
1. Click the `Instances` link on the left.
1. Find your active VM and select it.
1. Select `Instance State` and then `Terminate (delete) instance`
1. In the confirmation dialog, select `Terminate (delete)`.





    