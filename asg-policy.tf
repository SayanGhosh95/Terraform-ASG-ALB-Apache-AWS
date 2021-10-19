resource "aws_autoscaling_policy" "my_asg_policy" {
    name = "web-server-auto-scale-policy"
    policy_type = "TargetTrackingScaling"
    autoscaling_group_name = aws_autoscaling_group.asg_sample.id
    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 60
    }
}