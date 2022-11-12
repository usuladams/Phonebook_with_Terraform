data "aws_vpc" "selected" {
  default = true
}

data "aws_subnets" "example" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}


resource "github_repository_file" "dbendpoint" {
  content = module.myapp-db.db_instance.address
  file = "dbserver.endpoint"
  repository = "Phonebook_with_Terraform"
  overwrite_on_create = true
  branch = "main"
}


module "myapp-cloudfront" {
  source = "./modules/cloudfront"
  domain_name = var.domain_name
  alb_dns_name = module.myapp-webserver.alb_dns_name.dns_name
}

module "myapp-db" {
  source = "./modules/db"
  db_sg_id = module.myapp_secgrp.db_sg.id
}

module "myapp-route53" {
  source = "./modules/route53"
  domain_name = var.domain_name
  cf_dist_domain_name = module.myapp-cloudfront.cf_dist_domain_name.domain_name 
  cf_dist_hosted_zone_id = module.myapp-cloudfront.cf_dist_hosted_zone_id.hosted_zone_id
}

module "myapp_secgrp" {
  source = "./modules/secgrp"
  vpc_id = data.aws_vpc.selected.id
}


module "myapp-webserver" {
  source = "./modules/webserver"
  server_sg_id= module.myapp_secgrp.server_sg.id
  alb_sg_id = module.myapp_secgrp.alb_sg.id
  github_repo_dbendpoint= github_repository_file.dbendpoint
  vpc_id = data.aws_vpc.selected.id
  subnet_id = data.aws_subnets.example.ids 
}
