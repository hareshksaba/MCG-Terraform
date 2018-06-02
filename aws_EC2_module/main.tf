resource "aws_instance" "test" {
  ami           = "ami-db710fa3"
  instance_type = "t2.micro"
}
