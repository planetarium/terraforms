variable "create_vpc" {
  description = "Whether to create a new VPC. Set to false to use an existing VPC."
  type        = bool
  default     = false
}

variable "existing_vpc_id" {
  description = "The ID of an existing VPC to use if create_vpc is set to false."
  type        = string
  default     = ""
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC. Required if creating a VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "create_subnets" {
  description = "Whether to create new subnets. Set to false to use existing subnets."
  type        = bool
  default     = false
}

variable "existing_subnet_ids_public" {
  description = "A list of existing public subnet IDs to use if create_subnets is set to false."
  type        = list(string)
  default     = []
}

variable "existing_subnet_ids_private" {
  description = "A list of existing private subnet IDs to use if create_subnets is set to false."
  type        = list(string)
  default     = []
}

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
