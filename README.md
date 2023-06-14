# ECS Fargate Microservice Zenith

![Zenith](./zenith_logo.png)

Zenith is a microservice-based application built using AWS ECS Fargate. It provides a scalable and resilient architecture for deploying and managing microservices in a containerized environment.

This repository contains the source code and configuration files for deploying and running Zenith on AWS ECS Fargate. It includes the necessary infrastructure setup, Dockerfiles, and sample microservices.

## Features

- Microservice architecture: Zenith is designed as a collection of independent microservices, each serving a specific business function.
- AWS ECS Fargate: Zenith leverages the power of AWS Elastic Container Service (ECS) and Fargate to deploy and manage containerized microservices.
- Scalability and elasticity: The infrastructure is designed to automatically scale based on the demand and load on the microservices.
- High availability and fault tolerance: Zenith implements fault-tolerant patterns to ensure the availability of the microservices even in the event of failures.
- Monitoring and logging: The application integrates with AWS CloudWatch for monitoring and logging purposes, providing insights into the system's behavior.
- CI/CD pipeline: The repository includes a sample CI/CD pipeline configuration for automating the deployment process.
- Checkov integration: Zenith incorporates Checkov, an open-source tool for static code analysis of infrastructure-as-code (IaC), to identify and prevent misconfigurations and security vulnerabilities in the AWS resources.

## Prerequisites

Before deploying Zenith, ensure that you have the following prerequisites:

- An AWS account with appropriate permissions to create resources like ECS clusters, task definitions, etc.
- Docker installed on your local machine for building and testing the microservices locally.
- AWS CLI configured with the appropriate credentials to interact with your AWS account.
- Familiarity with AWS ECS, Fargate, and other related services.
- Checkov installed on your local machine for infrastructure code analysis.

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