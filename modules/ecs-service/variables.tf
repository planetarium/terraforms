variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "cluster_id" {
  description = "The ID of the ECS cluster the service will run on"
  type        = string
}

variable "task_definition_arn" {
  description = "The ARN of the task definition the service will use"
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  type        = number
}

variable "launch_type" {
  description = "The launch type on which to run your service"
  type        = string
  default     = "FARGATE"
}

variable "target_group_arn" {
  description = "The ARN of the target group with which to register the service"
  type        = string
  default     = ""
}

variable "container_name" {
  description = "The name of the container to associate with the load balancer (as it appears in a container definition)"
  type        = string
  default     = ""
}

variable "container_port" {
  description = "The port on the container to associate with the load balancer"
  type        = number
  default     = 80
}

variable "subnets" {
  description = "The subnets associated with the task or service"
  type        = list(string)
}

variable "security_groups" {
  description = "The security groups associated with the task or service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Assign a public IP address to the ENI (Fargate launch type only)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
