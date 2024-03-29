## ELB
resource "aws_elb" "myteam-elb" {
  name			= "myteam-elb"
  subnets	  	= ["${aws_subnet.myteam-public-1.id}", "${aws_subnet.myteam-public-2.id}", "${aws_subnet.myteam-public-3.id}",]
  security_groups 	= ["${aws_security_group.myteam-web.id}"]
  listener {
    instance_port 	= 80
    instance_protocol	= "http"
    lb_port		= 80
    lb_protocol		= "http"
  }
  health_check {
    healthy_threshold 	= 2
    unhealthy_threshold = 2
    timeout		= 3
    target		= "http:80/"
    interval		= 30
  }
  cross_zone_load_balancing   = true
  connection_draining	      = true
  connection_draining_timeout = 400
  tags {
    Name		= "myteam-elb"
  }
}
