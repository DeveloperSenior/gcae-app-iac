/** 
 * @author Andres Felipe Escobar López
 * @date 2024
 * @copyright Tecnologico de Antioquia 2024
 */

resource "aws_cloudwatch_log_group" "gcae_app_cloudwatch_lg" {
  name = var.cloudwatch_logs_group
  retention_in_days = 14
  tags = var.additional_tags
}