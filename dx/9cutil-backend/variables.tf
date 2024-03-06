variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
}

variable "mongodb_username" {
  description = "Mongodb username"
  type        = string
}

variable "mongodb_password" {
  description = "Mongodb password"
  type        = string
}
