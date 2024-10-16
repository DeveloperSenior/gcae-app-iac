/** 
 * @author Andres Felipe Escobar López
 * @date 2024
 * @copyright Tecnologico de Antioquia 2024
 */

terraform {

  backend "s3" {
    bucket = "gcae-state-backend-terraform"
    key    = "state/dllo/gcae-api/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

module "CloudWatch-Logs-groups" {
  source                = "../shared/modules/cloudwatch"
  cloudwatch_logs_group = local.cloudwatch_logs_group
  additional_tags       = local.additional_tags
}

module "ECR-Repository" {
  source          = "../shared/modules/ecr"
  ecr_repo_name   = local.ecr_repo_name
  additional_tags = local.additional_tags
}

module "ECS-Cluster" {
  source = "../shared/modules/ecs"

  gcae_app_cluster_name = local.gcae_app_cluster_name
  availability_zones    = local.availability_zones

  gcae_app_task_famliy         = local.gcae_app_task_famliy
  gcae_app_task_memory         = local.gcae_app_task_memory
  gcae_app_task_cpu            = local.gcae_app_task_cpu
  ecr_repo_url                 = module.ECR-Repository.repository_url
  container_port               = local.container_port
  gcae_app_task_name           = local.gcae_app_task_name
  ecs_task_execution_role_name = local.ecs_task_execution_role_name

  application_load_balancer_name = local.application_load_balancer_name
  target_group_name              = local.target_group_name
  gcae_app_service_name          = local.gcae_app_service_name
  gcae_app_service_network_mode  = local.gcae_app_service_network_mode
  gcae_app_service_launch_type   = local.gcae_app_service_launch_type

  gcae_app_awslogs_group         = local.cloudwatch_logs_group
  gcae_app_awslogs_region        = data.aws_region.current.name
  gcae_app_awslogs_stream_prefix = local.cloudwatch_logs_stream_prefix

  additional_tags = local.additional_tags

}