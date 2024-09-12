/** 
 * @author Andres Felipe Escobar López
 * @date 2024
 * @copyright Tecnologico de Antioquia 2024
 */

variable "gcae_app_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "availability_zones" {
  description = "us-east-1 AZs"
  type        = list(string)
}

variable "gcae_app_task_famliy" {
  description = "ECS Task Family"
  type        = string
}

variable "ecr_repo_url" {
  description = "ECR Repo URL"
  type        = string
}

variable "container_port" {
  description = "Container Port"
  type        = number
}

variable "gcae_app_task_name" {
  description = "ECS Task Name"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "ECS Task Execution Role Name"
  type        = string
}

variable "gcae_app_task_memory" {
  description = "ECS Task memory"
  type        = number
}

variable "gcae_app_task_cpu" {
  description = "ECS Task vCPU"
  type        = number
}

variable "application_load_balancer_name" {
  description = "ALB Name"
  type        = string
}

variable "target_group_name" {
  description = "ALB Target Group Name"
  type        = string
}

variable "gcae_app_service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "gcae_app_service_network_mode" {
  description = "ECS network mode"
  type        = string
}

variable "gcae_app_service_launch_type" {
  description = "ECS launch type"
  type        = string
}

variable "gcae_app_awslogs_group" {
    description = "Logs group"
    type = string
}

variable "gcae_app_awslogs_region" {
    description = "Region logs group"
    type = string
}

variable "gcae_app_awslogs_stream_prefix" {
    description = "Prefix region logs group"
    type = string
}

variable "additional_tags" {
   default = {}
   description = "Additional resource tag"
   type = map(string)
}