provider "aws" {
  region  = "us-east-1"
}

module "private_layer"{
  source = "./private_layer"
}

resource "aws_route53_zone" "csv" {
  for_each = { for r in [] : replace(r.domain, ".", "_") => r }
  vpc {
    vpc_id = "vpc-1234"
  }
  name = each.value.domain
}