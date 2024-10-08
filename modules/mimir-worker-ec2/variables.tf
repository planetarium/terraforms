variable "cpu" {
  description = "The number of CPU units used by the task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "The amount of memory used by the task (in MiB)"
  type        = number
  default     = 512
}

variable "ecs_capacity_provider_name" {
  description = "ecs_capacity_provider name"
  type        = string
}

variable "image_tag" {
  description = "Docker Image tag"
  type        = string
  default     = "git-aa7e94562660561a24565f5581396c4fffdf1336"
}

variable "repository_credentials" {
  description = "Credentials to access Docker registry"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
  default     = ""
}

variable "cluster_id" {
  type        = string
  description = "ID of the ECS cluster"
  default     = ""
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  type        = number
}

variable "private_subnets" {
  description = "The list of private subnet IDs for the task or service"
  type        = list(string)
}

variable "public_subnets" {
  description = "The list of public subnet IDs for the task or service"
  type        = list(string)
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "planet_type" {
  description = "The planet type (e.g., odin, heimdall)"
  type        = string
}

variable "poller_type" {
  description = "poller_type"
  type        = string
}

variable "short_poller_type" {
  description = "short_poller_type"
  type        = string
}

variable "headless_endpoints" {
  description = "headless_endpoints"
  type        = list(string)
}

variable "use_jwt" {
  description = "Flag to include JWT related secrets"
  type        = bool
  default     = true
}

variable "tags" {
  type = object({
    Team = string
  })
  description = "AWS resources' tags."
}

locals {
  kebab_case_prefix = "${var.cluster_name}-worker-${var.planet_type}-${var.short_poller_type}-${var.environment}"
}
