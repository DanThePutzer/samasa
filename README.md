# samasa

**samasa (समास)** - Sanskrit for ***"fusion"***

This project brings together a variety of popular technologies in the field of DevOps to build a production-ready CI/CD environment.  
We dockerize a simple Flask application, provision the necessary infrastructure with AWS CloudFormation and deploy our Docker image to an AWS EKS Kubernetes cluster.
The whole thing serves as submission for the cap stone project the [Cloud DevOps Engineer](https://www.udacity.com/course/cloud-dev-ops-nanodegree--nd9991) Udacity course.

**Key Technologies:** AWS CloudFormation, Jenkins, Docker, Kubernetes, Ansible

![CI-CD](https://user-images.githubusercontent.com/25454503/89062898-8b470100-d367-11ea-9c5a-cad98e16424c.png)

### Infrastructure as Code (IaC)

The **cloud-formation** directory in the repository contains scripts to deploy all the necessary infrastructure for this project. The table below outlines which file does what.

| **CloudFormation Script** | **Description**                                                                                        |
|---------------------------|--------------------------------------------------------------------------------------------------------|
| **network.yml**           | Deploys all the necessary network infrastructure (VPC, Subnets, NAT & Internet Gateways etc.)          |
| **bastion.yml**           | Deploys an EC2 instance that serves as a bastion host to manage Jenkins and the Kubernetes cluster     |
| **cluster.yml**           | Deploys an EKS cluster for Kubernetes to deploy our docker images to                                   |

The infrastructure can be deployed using the AWS CLI. An example command deploying the EC2 bastion host can be seen below.

```bash
# Deploying a CloudFormation stack
aws cloudformation create-stack --stack-name SamasaBastion --template-body file://bastion.yml --parameters file://bastionParams.json --region us-west-2 --capabilities CAPABILITY_IAM
```

### CI/CD Pipeline

As can be seen in the Jenkinsfile in this repo, our CI/CD pipeline contains various steps, we install necessary dependencies, lint our Dockerfile and python code, build and push our Docker image and finally deploy the image on our Kubernetes cluster. Check out the Jenkinsfile for more details.  
In terms of deployment strategy I opted for blue-green deployment using Jenkins. Check out the **blue** and **green** branches of this repo for more.

To run the project, a few things need to be configured first:  
1. **Set up Jenkins**  
Access the public IP of your bastion host at port **8080** and follow the instructions to configure Jenkins
2. **Install additionall Jenkins plugins**  
For this particular project we need Blue Ocean, CloudBees AWS Credentials and Docker  
3. **Add Docker Hub and AWS credentials to jenkins configuration**  
On the jenkins home page go to ```Manage Jenkins > Manage Credentials > Jenkins > Global Credentials > Add Credentials```
4. **Create a CI/CD pipeline using Blue Ocean**  
Open Blue Ocean and follow the steps to create a pipeline from a GitHub repository

### Kubernetes Cluster

While the physical cluster itself gets provisioned with AWS CloudFormation as outlined above, there is more to it than that. We manage our cluster with **kubectl** and use various Ansible playbooks to deploy Docker images to it.
the **deployment** directory contains said Ansible playbooks. An overview is provided in the table below.


| **Ansible Playbook**           | **Description**                                                                   |
|--------------------------------|-----------------------------------------------------------------------------------|
| **samasa-blue.yml**            | Creates Kubernetes service based on our Docker image for the **Blue** branch      |
| **samasa-green.yml**           | Creates Kubernetes service based on our Docker image for the **Green** branch     |
| **load-balancer-blue.yml**     | Configures Load Balancer to switch to **Blue** branch                             |
| **load-balancer-green.yml**    | Configures Load Balancer to switch to **Green** branch                            |

When everything is deployed correctly, you should be able to commit to either the green or the blue branch and if everything checks out (passes linting, builds and pushes Docker image etc.) the Jenkins pipeline should automatically switch to the newest functional branch.

&nbsp;

![Daniel Putzer, 2020](https://i.ibb.co/LSxTsY3/dan.png "Daniel Putzer, 2020")  
<https://danielputzer.com>
