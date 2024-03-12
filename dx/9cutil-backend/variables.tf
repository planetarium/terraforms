variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Region"
  default     = "us-east-2"
}

variable "ninecub_image" {
  description = "ninecub image"
}

variable "ninecubs_image" {
  description = "ninecubs image"
}

variable "zeroc_image" {
  description = "zeroc image"
}

locals {
  kebab_case_prefix = "${var.cluster_name}-${var.environment}"
}
