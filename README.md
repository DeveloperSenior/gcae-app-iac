# GCAE-APP-IaC
repository to manage IaC for the GCAE project

# Author
- [Andres Felipe Escobar Lopez](https://github.com/DeveloperSenior)

# Technology in which it was developed
- AWS
- Terraform

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
    L test
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
   READEME.md
```
# How to init terraform in the environment

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