resource "aws_lb" "sample" {
  name               = "terraform-asg-sample"
  internal = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.ssh-allowed.id}"]
  subnets            = ["${aws_subnet.subnet1.id}","${aws_subnet.subnet2.id}"]
  enable_cross_zone_load_balancing  = true
}

resource "aws_lb_target_group" "group" {
  name     = "terraform-example-alb-target"
  port     = 80
  protocol = "HTTP"
  depends_on = ["aws_vpc.prod-vpc"]
  vpc_id   = "${aws_vpc.prod-vpc.id}"
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/login"
    port = 80
  }
}

resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = "${aws_lb.sample.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.group.arn}"
    type             = "forward"
  }
}