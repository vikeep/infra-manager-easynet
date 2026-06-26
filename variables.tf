variable "region" {
  description = "Volcengine region"
  type        = string
  default     = "cn-beijing"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "vpc-demo"
}

variable "vpc_description" {
  description = "Description of the VPC"
  type        = string
  default     = "VPC created by Terraform"
}

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "subnet-demo"
}

variable "subnet_description" {
  description = "Description of the subnet"
  type        = string
  default     = "Subnet created by Terraform"
}

variable "subnet_cidr_block" {
  description = "CIDR block of the subnet"
  type        = string
  default     = "192.168.1.0/24"
}

variable "subnet_zone_id" {
  description = "Availability zone ID of the subnet"
  type        = string
  default     = "cn-beijing-a"
}

variable "tags" {
  description = "Tags applied to the VPC and subnet"
  type = list(object({
    key   = string
    value = string
  }))
  default = [
    {
      key   = "env"
      value = "prod"
    }
  ]
}
