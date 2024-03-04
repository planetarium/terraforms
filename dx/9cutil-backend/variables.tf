variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet IDs for the ECS service"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "mongodb_username" {
  description = "Mongodb username"
  type        = string
}

variable "mongodb_password" {
  description = "Mongodb password"
  type        = string
}
