provider "aws" {
    region = "${var.aws_region}"
    tags = {
        Environment = var.environment
    }
}

terraform {
  backend "s3" {
    bucket         = "hypha-terraform-state"
    key            = "test/terraform.tfstate"
    region         = "us-east-2"
  }
}

module "network" {
    source = "../../modules/network"
    vpc_cidr_block = var.vpc_cidr_block
    public_subnet_1 = var.public_subnet_1
    public_subnet_2 = var.public_subnet_2
    private_subnet_1 = var.private_subnet_1
    private_subnet_2 = var.private_subnet_2
}

module "compute" {
    source = "../../modules/compute"
    public_key_path = var.public_key_path
    instance_type = var.instance_type
    vpc-id = module.network.vpc-id
    public-subnet-1-id = module.network.public-subnet-1-id
    public-subnet-2-id = module.network.public-subnet-2-id
    private-subnet-1-id = module.network.private-subnet-1-id
    private-subnet-2-id = module.network.private-subnet-2-id
    lb-sg-id = module.network.lb-sg-id
    webserver-sg-id = module.network.webserver-sg-id
    bastion-sg-id = module.network.bastion-sg-id
}