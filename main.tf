provider "aws" {
	region = "us-eastt-1"
}

resource "aws_instance" "test"{
	ami = "ami-e251209a"
	instance_type = "t2.micro"
}