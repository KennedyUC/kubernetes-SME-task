variable "project_name" {
  description = "name of the project"
  type        = string
}

variable "env" {
  description = "environment"
  type        = string
}

variable "k8s_version" {
  description = "kubernetes version"
  type        = string
}

variable "public_subnets_ids" {
  description = "list of public subnet ids"
  type        = list
}

variable "private_subnets_ids" {
  description = "list of private subnet ids"
  type        = list
}