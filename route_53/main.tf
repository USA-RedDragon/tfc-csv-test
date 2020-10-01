module "private_layer"{
  source = "./private_layer"
  environment_tag = var.environment_tag
  name_tag = var.name_tag
  vpc_id = var.vpc_id
}