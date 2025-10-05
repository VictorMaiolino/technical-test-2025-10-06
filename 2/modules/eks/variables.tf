variable "cluster_name" { type = string }
variable "cluster_version" { type = string }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }

variable "node_min_size" { type = number }
variable "node_desired_size" { type = number }
variable "node_max_size" { type = number }
variable "instance_types" { type = list(string) }

variable "autoscaler_sa_name" { type = string }
variable "autoscaler_namespace" { type = string }
variable "tags" { type = map(string) }
