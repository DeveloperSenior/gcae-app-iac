variable "additional_tags" {
  default = {
    "Ambiente"            = "Producción"
    "AnalistaResponsable" = "Andres Felipe Escobar Lopez"
    "Compania"            = "Tecnologico de Antioquia"
    "LiderProyecto"       = "Andres Felipe Escobar Lopez"
    "NombreProyecto"      = "GCAE-PROD"
    "IaC"                 = "Terraform"
  }
  description = "Additional resource tags"
  type        = map(string)
}

variable "stage" {
  default     = "prod"
  description = "stage app"
  type        = string
}