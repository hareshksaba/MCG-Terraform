provider "aws" {
  version    = "~> 1.20"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

data "aws_availability_zones" "available" {}

module "aws_S3_module" {
  source = "./aws_S3_module"
}

module "aws_LB_module" {
  source = "./aws_LB_module"
}

module "aws_AutoScale_module" {
  source = "./aws_AutoScale_module"
}

module "aws_EC2_module" {
  source = "./aws_EC2_module"
}

/*module "aws_IAM_module" {
  source = "./aws_IAM_module"
}*/

