variable "access_key" {
  default = "AKIAJIUGPNZMM6QKZXBQ"
}

variable "secret_key" {
  default = "E4VC+vJJTCkCiKNOY9xUJjChVJapdPxuZ6EMsFBc"
}

variable "region" {
  default = "us-west-2"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default     = 8080
}

variable "ami"{
  default = "ami-db710fa3"
}