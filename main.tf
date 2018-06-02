provider "aws" {
  version    = "~> 1.20"
  access_key = "AKIAJIUGPNZMM6QKZXBQ"
  secret_key = "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"
  region     = "us-west-2"
}

resource "aws_instance" "test" {
  ami           = "ami-db710fa3"
  instance_type = "t2.micro"
}

/*module "website" {
  source    = "git::https://github.com/cloudposse/terraform-aws-s3-website.git?ref=master"
  namespace = "cp"
  stage     = "prod"
  name      = "hareshkanagasabapathi12345-app"
  hostname  = "hkby.docs.prod.cloudposse.org"

  deployment_arns = {
    "arn:aws:s3:::principal1" = ["/prefix1", "/prefix2"]
    "arn:aws:s3:::principal2" = [""]
  }
}*/

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

module "aws_IAM_module" {
  source = "./aws_IAM_module"
}
