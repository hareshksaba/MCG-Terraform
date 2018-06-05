/*
Code the following using modules
A highly available autoscaling group
Min 2 EC2s, max 5 EC2s in 2 different zones
CPU at 85% triggers the scaling
One S3 bucket
IAM role to allow access to the S3 bucket
Application Load Balancer with a target group that will contain the EC2s from the autoscaling group
*/ 

# Setting AWS as provider and setting default region using variables
provider "aws" {
  version    = "~> 1.20"
 # access_key = "${var.access_key}" -- not safe to store in variable file
 # secret_key = "${var.secret_key}" -- not safe
  region     = "${var.region}"
}

# Reads available availability zones

data "aws_availability_zones" "available" {}

# Using Modules to spin up services on AWS

/*This module will create an autoscaling group
Min 2 EC2s, max 5 EC2s in 2 different zones
CPU at 85% triggers the scaling */

module "aws_AutoScale_module" {
  source = "./aws_AutoScale_module"
}

/*
This module will create an S3 bucket 
and create an IAM role to allow access to the above S3 bucket
*/

module "aws_S3_module" {
  source = "./aws_S3_module"
}

/*
This module will create an Application Load Balancer 
with a target group that will contain the EC2s from the above autoscaling group
*/

module "aws_ALB_module" {
  source = "./aws_ALB_module"
}