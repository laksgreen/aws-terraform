## define SSH key pairs
resource "aws_key_pair" "devops1" {
  key_name   = "devops1"
  public_key = "${file(var.PUBLIC_KEY_PATH)}"
}

