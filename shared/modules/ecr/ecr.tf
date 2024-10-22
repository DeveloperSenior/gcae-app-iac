/** 
 * @author Andres Felipe Escobar López
 * @date 2024
 * @copyright Tecnologico de Antioquia 2024
 */

resource "aws_ecr_repository" "gcae_app_ecr_repo" {
  name = var.ecr_repo_name
  tags = var.additional_tags
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = true
  }
}