variable "access_key" {
  default = "AKIAIPKY5QVGRZCDPBEQ"
}

variable "secret_key" {
  default = "RgBOCOnwF5zJOpqmJ90k4N51Z0lEdFmg1dVJqRiJ"
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