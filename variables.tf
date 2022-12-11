variable "base_domain" {
  type        = string
  description = "base domain used for app urls"
}

variable "prometheus_versions" {
}

variable "namespace" {
  type = string
}

variable "environment" {
  type = string
}

variable "monitoring" {
}

variable "labels" {
  type = object({
    environment = string
    region      = string
  })
}

variable "ingressClassName" {}
variable "argocd_project" {}