## define SSH key pairs
resource "aws_instance" "web" {
  ami               = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type     = "t2.micro"
  availability_zone = "${var.AWS_REGION}a"
  key_name          = "${aws_key_pair.devops1.key_name}"
  security_groups   = ["${aws_security_group.myteam-web.id}"]
  subnet_id         = "${aws_subnet.myteam-public-1.id}"

  connection {
    host        = "${self.public_ip}"
    user        = "${var.INSTANCE_USERNAME}"
    private_key = "${file(var.PRIVATE_KEY_PATH)}"
  }
}

## Gets output public IP
output "ip" {
  value = "${aws_instance.web.public_ip}"
}
