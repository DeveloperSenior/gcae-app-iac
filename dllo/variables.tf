variable "additional_tags" {
  default = {
    "Ambiente"            = "Desarrollo"
    "AnalistaResponsable" = "Andres Felipe Escobar Lopez"
    "Compania"            = "Tecnologico de Antioquia"
    "LiderProyecto"       = "Andres Felipe Escobar Lopez"
    "NombreProyecto"      = "GCAE-DLLO"
    "IaC"                 = "Terraform"
  }
  description = "Additional resource tags"
  type        = map(string)
}

variable "stage" {
  default     = "dllo"
  description = "stage app"
  type        = string
}