variable "instance_type" {
  description = "The instance type"
  type        = string
  default     = "t3.medium"
}

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
variable "image" {
  description = "Docker Image tag"
  type        = string
  default     = "git-aa7e94562660561a24565f5581396c4fffdf1336"
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
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

variable "create_cluster" {
  description = "A boolean flag to control whether the ECS cluster should be created"
  type        = bool
  default     = false
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  type        = number
}

variable "subnets" {
  description = "The list of subnet IDs for the task or service"
  type        = list(string)
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}
