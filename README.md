# ECS Fargate Microservice Zenith

![Zenith]

Zenith is a microservice-based application built using AWS ECS Fargate. It provides a scalable and resilient architecture for deploying and managing microservices in a containerized environment.

This repository contains the source code and configuration files for deploying and running Zenith on AWS ECS Fargate. It includes the necessary infrastructure setup, Dockerfiles, and sample microservices.

## Outputs

![Screenshot from 2023-06-30 10-00-30](https://github.com/DevBarham/ECS-Fargate-Microservice-Zenith/assets/58726365/08407f0a-dd80-4f0f-944c-a31cae3131d8)
![Screenshot from 2023-06-30 10-00-48](https://github.com/DevBarham/ECS-Fargate-Microservice-Zenith/assets/58726365/3006d01b-cea1-46c0-986f-9dab7668fb66)

## Features

- Microservice architecture: Zenith is designed as a collection of independent microservices, each serving a specific business function.
- AWS ECS Fargate: Zenith leverages the power of AWS Elastic Container Service (ECS) and Fargate to deploy and manage containerized microservices.
- Scalability and elasticity: The infrastructure is designed to automatically scale based on the demand and load on the microservices.
- High availability and fault tolerance: Zenith implements fault-tolerant patterns to ensure the availability of the microservices even in the event of failures.
- Monitoring and logging: The application integrates with AWS CloudWatch for monitoring and logging purposes, providing insights into the system's behavior.
- CI/CD pipeline: The repository includes a sample CI/CD pipeline configuration for automating the deployment process.
- Checkov integration: Zenith incorporates Checkov, an open-source tool for static code analysis of infrastructure-as-code (IaC), to identify and prevent misconfigurations and security vulnerabilities in the AWS resources.

## Infrastructure

The Infrastructure folder contains the terraform code to deploy the AWS resources. The Modules folder has been created to store the Terraform modules used in this project. The Templates folder contains the different configuration files needed within the modules. The Terraform state is stored locally in the machine where you execute the terraform commands, but feel free to set a Terraform backend configuration like an AWS S3 Bucket or Terraform Cloud to store the state remotely. The AWS resources created by the script are detailed bellow:

AWS Networking resources, following best practices for HA
2 ECR Repositories
1 ECS Cluster
2 ECS Services
2 Task definitions
4 Autoscaling Policies + Cloudwatch Alarms
2 Application Load Balancer (Public facing)
IAM Roles and policies for ECS Tasks, CodeBuild, CodeDeploy and CodePipeline
Security Groups for ALBs and ECS tasks
2 CodeBuild Projects
2 CodeDeploy Applications
1 CodePipeline pipeline
2 S3 Buckets (1 used by CodePipeline to store the artifacts and another one used to store assets accessible from within the application)
1 DynamoDB table (used by the application)
1 SNS topic for notifications

![ecs-fargate](https://github.com/DevBarham/ECS-Fargate-Microservice-Zenith/assets/58726365/542b36c8-4829-402c-bfd1-a13e1762a69b)

## Prerequisites

Before deploying Zenith, ensure that you have the following prerequisites:

- An AWS account with appropriate permissions to create resources like ECS clusters, task definitions, etc.
- Docker installed on your local machine for building and testing the microservices locally.
- AWS CLI configured with the appropriate credentials to interact with your AWS account.
- Familiarity with AWS ECS, Fargate, and other related services.
- Checkov installed on your local machine for infrastructure code analysis.

There are general steps that you must follow in order to launch the infrastructure resources.

Before launching the solution please follow the next steps:

Install Terraform, use Terraform v0.13 or above. You can visit this Terraform official webpage to download it.
Configure the AWS credentials into your machine (~/.aws/credentials). You need to use the following format:
    
```shell
    [AWS_PROFILE_NAME]
    aws_access_key_id = Replace_with_the_correct_access_Key
    aws_secret_access_key = Replace_with_the_correct_secret_Key
```
Generate a GitHub token. You can follow this steps to generate it.
Usage
1. Fork this repository and create the GitHub token granting access to this new repository in your account.

2. Clone that recently forked repository from your account (not the one from the aws-sample organization) and change the directory to the appropriate one as shown below:
```shell
cd Infrastructure/
```
3. Run Terraform init to download the providers and install the modules
```shell
terraform init
``` 
4. Run the terraform plan command, feel free to use a tfvars file to specify the variables. You need to set at least the following variables:

- aws_profile = according to the profiles name in ~/.aws/credentials
- aws_region = the AWS region in which you want to create the resources
- environment_name = a unique name used for concatenation to give place to the resources names
- github_token = your GitHub token, the one generated a few steps above
- repository_name = your GitHub repository name
- repository_owner = the owner of the GitHub repository used
```shell
terraform plan -var aws_profile="your-profile" -var aws_region="your-region" -var environment_name="your-env" -var github_token="your-personal-token" -var repository_name="your-github-repository" -var repository_owner="the-github-repository-owner"
```
Example of the previous command with replaced dummy values:
```shell
terraform plan -var aws_profile="development" -var aws_region="eu-central-1" -var environment_name="developmentenv" -var github_token="your-personal-token" -var repository_name="your-github-repository" -var repository_owner="the-github-repository-owner"
```
5. Review the terraform plan, take a look at the changes that terraform will execute:

```shell
terraform apply -var aws_profile="your-profile" -var aws_region="your-region" -var environment_name="your-env" -var github_token="your-personal-token" -var repository_name="your-github-repository" -var repository_owner="the-github-repository-owner"
```
6. Once Terraform finishes the deployment, open the AWS Management Console and go to the AWS CodePipeline service. You will see that the pipeline, which was created by this Terraform code, is in progress. Add some files and DynamoDB items as mentioned here. Once the pipeline finished successfully and the before assets were added, go back to the console where Terraform was executed, copy the application_url value from the output and open it in a browser.

7. In order to access the also implemented Swagger endpoint, copy the swagger_endpoint value from the Terraform output and open it in a browser.

Autoscaling test
To test how your application will perform under a peak of traffic, a stress test configuration file is provided.

For this stress test Artillery is being used. Please be sure to install it following these steps.

Once installed, please change the ALB DNS to the desired layer to test (front/backend) in the target attribute, which you can copy from the generated Terraform output, or you can also search it in the AWS Management Console.

To execute it, run the following commands:

Frontend layer:
```shell

artillery run Code/client/src/tests/stresstests/stress_client.yml
Backend layer:
```
```shell
artillery run Code/server/src/tests/stresstests/stress_server.yml
```
To learn more about Amazon ECS Autoscaling, please take a look to the documentation.

## Application Code
## Client app
The Client folder contains the code to run the frontend. This code is written in Vue.js and uses the port 80 in the deployed version, but when run localy it uses port 3000.

The application folder structure is separeted in components, views and services, despite the router and the assets.

## Client considerations due to demo proposals
The assets used by the client application are going to be requested from the S3 bucket created with this code. Please add 3 images to the created S3 bucket.

The DynamoDB structure used by the client application is the following one:
```shell
  - id: N (HASH)
  - path: S
  - title: S
  ```
Feel free to change the structure as needed. But in order to have full demo experience, please add 3 DynamoDB Items with the specified structure from above. Below is an example.

Note: The path attribute correspondes to the S3 Object URL of each added asset from the previous step.

Example of a DynamoDB Item:
```shell
{
  "id": {
    "N": "1"
  },
  "path": {
    "S": "https://mybucket.s3.eu-central-1.amazonaws.com/MyImage.jpeg"
  },
  "title": {
    "S": "My title"
  }
}
 ```
## Server app
The Server folder contains the code to run the backend. This code is written in Node.js and uses the port 80 in the deployed version, but when run localy it uses port 3001.

Swagger was also implemented in order to document the APIs. The Swagger endpoint is provided as part of the Terraform output, you can grab the output link and access it through a browser.

The server exposes 3 endpoints:

/status: serves as a dummy endpoint to know if the server is up and running. This one is used as the health check endpoint by the AWS ECS resources
/api/getAllProducts: main endpoint, which returns all the Items from an AWS DynamoDB table
/api/docs: the Swagger endpoint for the API documentation
Cleanup
Run the following command if you want to delete all the resources created before:
```shell
terraform destroy -var aws_profile="your-profile" -var AWS_REGION="your-region" -var environment_name="your-env" -var github_token="your-personal-token" -var repository_name="your-github-repository" - var repository_owner="the-github-repository-owner"
```

## Getting Started

To get started with Zenith, follow these steps:

1. Clone this repository to your local machine:

   ```shell
   git clone https://github.com/DevBarham/ECS-Fargate-Microservice-Zenith.git
   ```

2. Build and test the microservices locally. Each microservice has its own directory within the repository.

3. Configure your AWS credentials using the AWS CLI:

   ```shell
   aws configure
   ```

4. Deploy the required infrastructure for Zenith. The infrastructure setup is defined in the `infrastructure` directory.

5. Run Checkov to analyze the infrastructure code and identify any misconfigurations or security vulnerabilities:

   ```shell
   checkov -d infrastructure/
   ```

   Review the Checkov report and address any identified issues before proceeding with the deployment.

6. Deploy the microservices to AWS ECS Fargate using the provided deployment scripts or CI/CD pipeline.

7. Monitor the deployed microservices using AWS CloudWatch.

For detailed instructions on deploying and managing Zenith, please refer to the [documentation](./docs).

## Contributing

Contributions are welcome! If you'd like to contribute to Zenith, please follow these steps:

1. Fork this repository.

2. Create a new branch for your feature or bug fix:

   ```shell
   git checkout -b my-feature
   ```

3. Make the necessary changes and commit them:

   ```shell
   git commit -m "Implement new feature"
   ```

4. Push your changes to the forked repository:

   ```shell
   git push origin my-feature
   ```

5. Open a pull request in this repository with a detailed description of your changes.

Please review the [contribution guidelines](./CONTRIBUTING.md)

 for more information.

## License

This project is licensed under the [MIT License](./LICENSE).

## Acknowledgements

We would like to acknowledge the following resources and projects that have inspired and helped us in building Zenith:

- [AWS ECS Documentation](https://docs.aws.amazon.com/ecs)
- [Docker Documentation](https://docs.docker.com)
- [Microservices Architecture](https://microservices.io)
- [AWS CloudWatch Documentation](https://docs.aws.amazon.com/cloudwatch)
- [Checkov](https://github.com/bridgecrewio/checkov) - Open-source IaC static code analysis tool.

## Contact

For any questions or support, please contact the project maintainers at [Team-Zenith](mailto:saheedibrahimdamilare@gmail.com).


