data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
}

resource "aws_launch_configuration" "MCH-launch-config" {
  name_prefix   = "MCH-AutoScaling-LC-"
  image_id      = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "MCH-autoscaling-group" {
  availability_zones   = ["us-west-2a", "us-west-2b"]
  name                 = "terraform-asg-example"
  launch_configuration = "${aws_launch_configuration.MCH-launch-config.name}"
  min_size             = 2
  max_size             = 5

  lifecycle {
    create_before_destroy = true
  }
}
