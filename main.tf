terraform {
  required_providers {
    volcenginecc = {
      source = "volcengine/volcenginecc"
    }
  }
}

variable "region" {
  description = "Volcengine region"
  type        = string
  default     = "cn-guilin-boe"
}

variable "cloudcontrolapi_endpoint" {
  description = "Cloud Control API endpoint"
  type        = string
  default     = "open.stable.volcengineapi-test.com"
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
  default     = "cn-guilin-a"
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
      value = "test"
    }
  ]
}

provider "volcenginecc" {
  endpoints = {
    cloudcontrolapi = var.cloudcontrolapi_endpoint
  }

  region = var.region
}

resource "volcenginecc_vpc_vpc" "vpc-demo" {
  vpc_name    = var.vpc_name
  description = var.vpc_description
  cidr_block  = var.vpc_cidr_block

  tags = var.tags
}

resource "volcenginecc_vpc_subnet" "subnet-demo" {
  vpc_id      = volcenginecc_vpc_vpc.vpc-demo.id
  zone_id     = var.subnet_zone_id
  subnet_name = var.subnet_name
  description = var.subnet_description
  cidr_block  = var.subnet_cidr_block

  tags = var.tags
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.id
}

output "vpc_name" {
  description = "Name of the created VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.vpc_name
}

output "vpc_cidr_block" {
  description = "CIDR block of the created VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.cidr_block
}

output "vpc_description" {
  description = "Description of the created VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.description
}

output "vpc_status" {
  description = "Status of the created VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.status
}

output "vpc_creation_time" {
  description = "Creation time of the VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.creation_time
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.id
}

output "subnet_name" {
  description = "Name of the created subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.subnet_name
}

output "subnet_cidr_block" {
  description = "CIDR block of the created subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.cidr_block
}

output "subnet_description" {
  description = "Description of the created subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.description
}

output "subnet_zone_id" {
  description = "Availability zone ID of the subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.zone_id
}

output "subnet_status" {
  description = "Status of the subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.status
}

output "subnet_available_ip_count" {
  description = "Number of available IP addresses in the subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.available_ip_address_count
}
