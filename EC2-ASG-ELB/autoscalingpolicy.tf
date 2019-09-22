## autoscaling policy 
resource "aws_autoscaling_policy" "autoscaling-cpu-policy" {
  name			 = "autoscaling-cpu-policy"
  autoscaling_group_name = "${aws_autoscaling_group.myteam-autoscaling.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment	 = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "autoscaling-cpu-alarm" {
  alarm_name             = "autoscaling-cpu-alarm"
  alarm_description      = "autoscaling-cpu-alarm"
  comparison_operator    = "GreaterThanOrEqualToThreshold"
  evaluation_periods     = "2"
  metric_name	         = "CPUUtilization"
  namespace              = "AWS/EC2"
  period                 = "120"
  statistic              = "Average"
  threshold              = "30"
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.myteam-autoscaling.name}"
  }
  actions_enabled         = true
  alarm_actions	         = ["${aws_autoscaling_policy.autoscaling-cpu-policy.arn}"]
}
## autoscaling policy for DOWN
resource "aws_autoscaling_policy" "autoscaling-cpu-policy-down" {
  name			 = "autoscaling-cpu-policy-down"
  autoscaling_group_name = "${aws_autoscaling_group.myteam-autoscaling.name}"
  adjustment_type	 = "ChangeInCapacity"
  scaling_adjustment	 = "-1"
  cooldown		 = "120"
  policy_type            = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "autoscaling-cpu-alarm-down" {
  alarm_name		 = "autoscaling-cpu-alarm-down"
  alarm_description	 = "autoscaling-cpu-alarm-down"
  comparison_operator 	 = "LessThanOrEqualToThreshold"
  evaluation_periods     = "2"
  metric_name         	 = "CPUUtilization"
  namespace           	 = "AWS/EC2"
  period              	 = "120"
  statistic           	 = "Average"
  threshold           	 = "5"
  
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.myteam-autoscaling.name}"
   }
    actions_enabled	 = true
    alarm_actions  	 = ["${aws_autoscaling_policy.autoscaling-cpu-policy-down.arn}"]
}
