provider "aws"{
    access_key = "AKIAJIUGPNZMM6QKZXBQ"
    secret_key = "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"
    region = "us-west-2"
}

resource "aws_instance" "test"{
	ami = "ami-db710fa3"
	instance_type = "t2.micro"
}