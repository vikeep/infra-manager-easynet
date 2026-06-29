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

resource "volcenginecc_vpc_subnet" "subnet-demo-2" {
  vpc_id      = volcenginecc_vpc_vpc.vpc-demo.id
  zone_id     = var.subnet_zone_id
  subnet_name = var.subnet2_name
  description = var.subnet_description
  cidr_block  = var.subnet2_cidr_block

  tags = var.tags
}
