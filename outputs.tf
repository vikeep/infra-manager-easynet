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

output "subnet2_id" {
  description = "ID of the second subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo-2.id
}

output "subnet2_name" {
  description = "Name of the second subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo-2.subnet_name
}

output "subnet2_cidr_block" {
  description = "CIDR block of the second subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo-2.cidr_block
}
