variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "container_insights" {
  description = "Whether CloudWatch Container Insights is enabled for the cluster"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
