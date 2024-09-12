/** 
 * @author Andres Felipe Escobar López
 * @date 2024
 * @copyright Tecnologico de Antioquia 2024
 */

variable "cloudwatch_logs_group" {
    description = "Logs group"
    type = string
}

variable "additional_tags" {
   default = {}
   description = "Additional resource tag"
   type = map(string)
}