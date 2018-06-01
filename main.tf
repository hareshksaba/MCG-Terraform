provider "aws" {
  access_key = "AKIAJIUGPNZMM6QKZXBQ"
  secret_key = "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"
  region     = "us-west-2"
}

resource "aws_instance" "test" {
  ami           = "ami-db710fa3"
  instance_type = "t2.micro"
}

module "website" {
  source    = "git::https://github.com/cloudposse/terraform-aws-s3-website.git?ref=master"
  namespace = "cp"
  stage     = "prod"
  name      = "hareshkanagasabapathi12345-app"
  hostname  = "hkby.docs.prod.cloudposse.org"

  deployment_arns = {
    "arn:aws:s3:::principal1" = ["/prefix1", "/prefix2"]
    "arn:aws:s3:::principal2" = [""]
  }
}
