## define SSH key pairs
resource "aws_instance" "web" {
  ami               = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type     = "t2.micro"
  availability_zone = "${var.AWS_REGION}a"
  key_name          = "${aws_key_pair.devops1.key_name}"
  security_groups   = ["${aws_security_group.myteam-web.id}"]
  subnet_id         = "${aws_subnet.myteam-public-1.id}"
#  delete_on_termination = "false"
#  volume_type 	    = "gp2"
#  volume_size 	    = "18"

  tags {
    Name	    = "myteam-web"
  }
  connection {
    host        = "${self.public_ip}"
    user        = "${var.INSTANCE_USERNAME}"
    private_key = "${file(var.PRIVATE_KEY_PATH)}"
  }
}
## Create a EBS volume with size and attachement
#resource "aws_ebs_volume" "ebs-vol1" {
#  availability_zone = "${var.AWS_REGION}a"
#  size		    = 20
#  type 		    = "gp2"
#  tags {
#    Name	    = "myteam-web"
#  }
#}
#resource "aws_volume_attachment" "ebs-vol1-attachment" {
#  device_name	   = "/dev/xvdh"
#  volume_id	   = "${aws_ebs_volume.ebs-vol1.id}"
#  instance_id	   = "${aws_instance.web.id}"
#}
## Gets output public IP
output "ip" {
  value = "${aws_instance.web.public_ip}"
}
