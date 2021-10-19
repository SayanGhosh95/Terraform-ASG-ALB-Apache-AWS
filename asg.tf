resource "aws_autoscaling_group" "asg_sample" {
  name = "asg_sample"
  desired_capacity   = 2
  max_size = 5
  min_size = 2
  force_delete       = true
  depends_on         = ["aws_lb.sample"]
  target_group_arns = ["${aws_lb_target_group.group.arn}"]
  health_check_type = "EC2"
  launch_configuration = aws_launch_configuration.asg-launch-config-sample.id
  vpc_zone_identifier = ["${aws_subnet.subnet1.id}","${aws_subnet.subnet2.id}"]
  tag {
    key                 = "Name"
    value               = "terraform-asg"
    propagate_at_launch = true
  }
}