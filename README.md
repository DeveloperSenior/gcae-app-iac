# GCAE-APP-IaC
repository to manage IaC for the GCAE project

# Author
- [Andres Felipe Escobar Lopez](https://github.com/DeveloperSenior)

# Technology in which it was developed
Before starting you must install Git, Terraform, Docker on your applicable operating system go to the official site [Install Terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform),
[Install Git](https://git-scm.com/downloads),
[Install Docker](https://docs.docker.com/engine/install/),
[Install Jenkins](https://www.jenkins.io/doc/book/installing/)

- VSCode [Install VSCode](https://code.visualstudio.com/download)
- Terraform
- AWS
- GIT
- Jenkins
- (Optional) Snyk: gives you the visibility, context, and control you need to work alongside developers on reducing application risk. [Install snyk](https://snyk.io/)

# Project's name
`GCAE FRAMEWORK for generating the BACK-END of an application from JSON objects (JSON-NODEJS Generator) under SOLID principles` software that automates the process of generating base code with standard architectures within the framework of SOLID principles focused on the Back-end.

# IaC Project Structure
The project was developed for the back-end with AWS S3 bucket, uses AWS, ECS (FARGATE), ECR, ALB, VPC Cloudwatch services

```
gcae-app-iac
    L dllo
        data.tf
        locals.tf
        main.tf
        providers.tf
        variables.tf
        jenkinsfile
        jenkisfile-windows
    L prod
        data.tf
        locals.tf
        main.tf
        providers.tf
        variables.tf
        jenkinsfile
        jenkisfile-windows
    L qa
        data.tf
        locals.tf
        main.tf
        providers.tf
        variables.tf
        jenkinsfile
        jenkisfile-windows
    L shared
        L cloudwatch
        L ecr
        L ecs
   .gitignore
   README.md
```

## Set up development environment

### Use VSCode IDE - How install [here](#technology-in-which-it-was-developed)

![VSCode gcae](/images/vscode.png)

### Install recommended VSCode plugins

* amazonwebservices.aws-toolkit-vscode
![AWS Plugin](/images/aws-plugin.png)
* ms-azuretools.vscode-docker 
![Docker Plugin](/images/docker-plugin.png)
* hashicorp.terraform 
![Terrafor Plugin](/images/terraform-plugin.png)
* SonarSource.sonarlint-vscode
![SonarLint Plugin](/images/sonarlint-plugin.png)


# How to init terraform in the environment

## Bucket Terraform State in AWS S3
**NOTE:** Before starting, the terraform state is stored in an S3 bucket on AWS called `gcae-state-backend-terraform` and this must exist in the account associated with the AWS CLI credentials

![GACE IaC Bucket AWS](/images/gcae-iac-bucket.png)

1. **Clone the Repository:**
```bash
git clone
https://github.com/DeveloperSenior/gcae-app-iac.git
```
2. **Init terraform modules:**
```bash
cd gcae-app-iac/dllo
terraform init -reconfigure
```
*NOTE:* To initialize the Terraform backend, the S3 bucket in AWS must exist to allow versioning of the infrastructure state, otherwise the Terraform initialization may fail. To skip storing the Terraform state in AWS, remove the backend statement from the `dllo/main.tf` file.
```javascript
    backend "s3" {
        ...
    }
```

3. **(Optional) How to format Terraform files:**
```bash
terraform fmt -recursive
```

4. **Validate the configuration of the IaC modules:**
```bash
terraform validate
```

5. **Run the AWS Modules Terraform plan to provision IaC:**
```bash
# create plan 
terraform plan -out tfplan

# show plan 
terraform show -no-color tfplan > tfplan.txt
```

6. **Apply terraform plan to Provision IaC in AWS:**

*NOTE:* Before applying the plan, keep in mind that this script provisions all modules configured for AWS services in the configured Amazon Web Services region and account.

```bash
# apply plan 
terraform apply -input=false tfplan
```

7. **(Optional) Run scan code security with snyk:**

```bash
# install snyk with npm
npm install -g snyk

# login snyk
snyk auth

# scan IaC with report
snyk iac test --report

```