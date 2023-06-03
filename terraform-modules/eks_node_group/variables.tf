variable "project_name" {
  description = "name of the project"
  type        = string
}

variable "env" {
  description = "environment"
  type        = string
}

variable "instance_type" {
  description = "node instance type"
  type        = string
}

variable "desired_node_count" {
  description = "number of desired node count"
  type        = number
}

variable "min_node_count" {
  description = "minimum node count"
  type        = number
}

variable "max_node_count" {
  description = "maximum node count"
  type        = number
}

variable "node_disk_size" {
  description = "node disk size"
  type        = number
}

variable "ami_type" {
  description = "instance ami type"
  type        = string
}

variable "capacity_type" {
  description = "instance capacity type"
  type        = string
}

variable "private_subnets_id" {
  description = "list of private subnets id"
  type        = list
}

variable "cluster_name" {
  description = "name of the eks cluster"
  type        = string
}

variable "k8s_version" {
  description = "kubernetes version of the eks cluster"
  type        = string
}