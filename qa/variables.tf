variable "additional_tags" {
  default = {
    "Ambiente"            = "QA"
    "AnalistaResponsable" = "Andres Felipe Escobar Lopez"
    "Compania"            = "Tecnologico de Antioquia"
    "LiderProyecto"       = "Andres Felipe Escobar Lopez"
    "NombreProyecto"      = "GCAE-QA"
    "IaC"                 = "Terraform"
  }
  description = "Additional resource tags"
  type        = map(string)
}

variable "stage" {
  default     = "qa"
  description = "stage app"
  type        = string
}