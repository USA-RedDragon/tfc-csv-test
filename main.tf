locals {
  ttl_default = 300
  a_ttl_default = local.ttl_default
  aaaa_ttl_default = local.ttl_default
  cname_ttl_default = local.ttl_default
  mx_ttl_default = local.ttl_default
  ns_ttl_default = local.ttl_default
  txt_ttl_default = local.ttl_default
  srv_ttl_default = local.ttl_default
  all_domain_records = csvdecode(file("${path.module}/domains.csv"))

  tags = {
    Environment = "Production"
    Name = "Domain CSV Test"
  }

  domain_rows = [
    for r in local.all_domain_records:
    r
    if lower(r.row_type) == "domain"
  ]
}

resource "aws_route53_zone" "csv" {
  for_each = { for r in local.domain_rows : replace(r.domain, ".", "_") => r }
  vpc {
    vpc_id = "vpc-1234"
  }
  name = each.value.domain
  tags = local.tags
}