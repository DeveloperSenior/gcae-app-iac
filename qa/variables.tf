variable "additional_tags" {
  default = {
    "Ambiente"            = "Test"
    "AnalistaResponsable" = "Andres Felipe Escobar Lopez"
    "Compania"            = "Tecnologico de Antioquia"
    "LiderProyecto"       = "Andres Felipe Escobar Lopez"
    "NombreProyecto"      = "GCAE-TEST"
    "IaC"                 = "Terraform"
  }
  description = "Additional resource tags"
  type        = map(string)
}

variable "stage" {
  default     = "test"
  description = "stage app"
  type        = string
}