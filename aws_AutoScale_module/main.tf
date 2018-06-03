data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
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
  min_size             = 2  max_size             = 5


  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_policy" "MCH-scaling-policy" {
  name                   = "MCH-scaling-policy"
  policy_type            = "TargetTrackingScaling"
  adjustment_type        = "PercentChangeInCapacity"
  #scaling_adjustment      = 1
  autoscaling_group_name = "${aws_autoscaling_group.MCH-autoscaling-group.name}"
  target_tracking_configuration {
  predefined_metric_specification {
    predefined_metric_type = "ASGAverageCPUUtilization"
  }
  target_value = 85.0
}
}