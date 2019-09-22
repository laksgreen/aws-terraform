##  Autoscaling policy minimum 1 maximnum, 3 instances, desired 2 instances
resource "aws_launch_configuration" "myteam-launchconfig" {
  name_prefix		= "myteam-launchconfig"
  image_id		= "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type		= "t2.micro"
  key_name		= "${aws_key_pair.devops1.key_name}"
  security_groups	= ["${aws_security_group.myteam-web.id}"]  ## Securitygroup name - myteam-web
  user_data		= "#!/bin/bash\napt-get update\napt-get install -y nginx\nPUBLIC_IP=`ifconfig | grep 'addr:10' | awk '{print $2}' | cut -d ':' -f2`\necho 'this is: '$PUBLIC_IP >/var/www/html/index.html"
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "myteam-autoscaling" {
  name			    = "myteam-autoscaling"
  vpc_zone_identifier	    = ["${aws_subnet.myteam-public-1.id}", "${aws_subnet.myteam-public-2.id}", "${aws_subnet.myteam-public-3.id}"]
  launch_configuration	    = "${aws_launch_configuration.myteam-launchconfig.name}"
  min_size		    = 2
  max_size		    = 3
  desired_capacity	    = 2
  health_check_grace_period = 300
## Loadbalancer setup
  health_check_type         = "ELB"
  load_balancers	    = ["${aws_elb.myteam-elb.name}"]
  force_delete		    = "true"
  tags {
    key			    = "myteam-autoscaling"
    value 		    = "ec2 instance"
    propagate_at_launch     = "true"
  }
  lifecycle {
    create_before_destroy = true
  }
}
