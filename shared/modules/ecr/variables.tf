/** 
 * @author Andres Felipe Escobar López
 * @date 2024
 * @copyright Tecnologico de Antioquia 2024
 */

variable "ecr_repo_name" {
  description = "ECR Repo Name"
  type        = string
}

variable "additional_tags" {
   default = {}
   description = "Additional resource tag"
   type = map(string)
}