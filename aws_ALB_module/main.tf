
variable "security_group_id" {
  type = "string"
  default = "sg-960d98e7"
}

data "aws_security_group" "selected" {
  id = "${var.security_group_id}"
}

resource "aws_subnet" "subnet" {
  vpc_id     = "${data.aws_security_group.selected.vpc_id}"
  cidr_block = "10.0.1.0/16"
}


data "aws_subnet_ids" "public" {
  vpc_id     = "${data.aws_security_group.selected.vpc_id}"
}

resource "aws_lb" "MCH-ALB" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.security_group_id}"]
  subnets            = ["${aws_subnet.subnet.*.id}"]

  enable_deletion_protection = true


  tags {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id     = "${data.aws_security_group.selected.vpc_id}"
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.MCH-ALB.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    target_group_arn = "${aws_lb_target_group.test.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "static" {
  listener_arn = "${aws_lb_listener.front_end.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.test.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/test/*"]
  }
}

/* Attempt to get autoscaling group name so that it can be attached to the below resource aws_autoscaling_attachment
    This is still not working as expected
*/
data "aws_autoscaling_groups" "groups" {
  filter {
    name = "key"
    values = ["name"]
  }

  filter {
    name = "value"
    values = ["auto_scaling_group_name"]
  }
}

resource "aws_autoscaling_attachment" "autoscale_attachment" {
  alb_target_group_arn   = "${aws_lb_target_group.test.arn}"

  // Need to figure out a way to dynamically add autoscaliing group name
  autoscaling_group_name = "terraform-asg-example"  
}
