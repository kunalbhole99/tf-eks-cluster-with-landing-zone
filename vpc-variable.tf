# VPC variables declaration:

variable "igw_tag" {
  description = "Mention Tag needs to be associated with internet gateway"
  type        = string

}
variable "public_route_table_tag" {
  description = "Tag name for public route table"
  type        = string

}
variable "private_route_table_1_tag" {
  description = "Tage for database route table"
  type        = string

}

variable "private_route_table_2_tag" {
  description = "Tage for database route table"
  type        = string

}

variable "cidr" {
  description = "Enter the CIDR range required for VPC"
  type        = string

}
variable "enable_dns_hostnames" {
  description = "Enable DNS Hostname"
  type        = bool

}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool

}

variable "vpc_name" {
  description = "Tag Name to be assigned with VPC"
  type        = string

}


variable "public_subnet_tag_1" {
  description = "Tag for public subnet"
  type        = string

}
variable "public_subnet_tag_2" {
  description = "Tag for public subnet"
  type        = string

}


variable "public_subnets_cidr_1" {
  description = "Cidr Blocks"
  type        = string

}
variable "public_subnets_cidr_2" {
  description = "Cidr Blocks"
  type        = string

}
variable "private_subnet_tag_1" {
  description = "Tag for Private Subnet"
  type        = string

}
variable "private_subnet_tag_2" {
  description = "Tag for Private Subnet"
  type        = string

}
variable "private_subnet_tag_3" {
  description = "Tag for Private Subnet"
  type        = string

}
variable "private_subnet_tag_4" {
  description = "Tag for Private Subnet"
  type        = string

}
variable "map_public_ip_on_launch" {
  description = "It will map the public ip while launching resources"
  type        = bool

}
variable "private_subnets_cidr_1" {
  description = "mention the CIDR block for database subnet"
  type        = string

}
variable "private_subnets_cidr_2" {
  description = "mention the CIDR block for database subnet"
  type        = string

}
variable "private_subnets_cidr_3" {
  description = "mention the CIDR block for database subnet"
  type        = string

}
variable "private_subnets_cidr_4" {
  description = "mention the CIDR block for database subnet"
  type        = string

}


variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

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