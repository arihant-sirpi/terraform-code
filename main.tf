provider "aws" {
region = var.aws_region
shared_config_files      = ["/root/.aws/config"]
shared_credentials_files = ["/root/.aws/credentials"]
profile = "default"
}

module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    az = var.az
    prv_cidr = var.prv_cidr
    pub_cidr = var.pub_cidr
    pub_rt_cidr = var.pub_rt_cidr
    prv_rt_cidr = var.prv_rt_cidr
}

module "keyfile"{
    source = "./modules/keyfile"
}
module "security_group" {
    source = "./modules/security_group"
    vpc_cidr = var.vpc_cidr
    vpc_id = module.vpc.vpcid

}

module "instances" {
    source = "./modules/instances"
    instance_type = var.instance_type
    pub1_sub = module.vpc.pub1_sub
    prv1_sub = module.vpc.prv1_sub
    sg-instance = module.security_group.sg-instance
}

module "target_group" {
  source = "./modules/target_group"
  vpc_id = module.vpc.vpcid
}


module "alb" {
source = "./modules/alb"
pub1_sub = module.vpc.pub1_sub
pub2_sub = module.vpc.pub2_sub
sg-alb = module.security_group.sg-alb
}
