provider "aws" {
  region  = "us-east-1"
  version = "3.8.0"
}


resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
}


module "route_53"{
  source = "./route_53"
  environment_tag = "Testing"
  name_tag = "TFC_CSV_TEST"
  vpc_id = aws_vpc.test_vpc.id
}

resource "aws_route53_zone" "csv" {
  for_each = { for r in [] : replace(r.domain, ".", "_") => r }
  vpc {
    vpc_id = "vpc-1234"
  }
  name = each.value.domain
}