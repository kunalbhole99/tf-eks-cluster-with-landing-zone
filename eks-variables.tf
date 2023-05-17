# EKS variables:

variable "eks_cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = number
}

variable "desired_size_of_node" {
  type = number
}

variable "max_size_of_node" {
  type = number
}

variable "min_size_of_node" {
  type = number
}