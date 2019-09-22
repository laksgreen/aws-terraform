





## AWS aws_region
variable "AWS_REGION" {
  default = "us-west-2"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
## AMIs for all the regions which you want to use
variable "AMIS" {
  type = "map"

  default = {
    us-west-2 = "ami-06f2f779464715dc5"
    us-east-1 = "ami-0ac019f4fcb7cb7e6"
  }
}
## SSH-Access-key pair
variable "PRIVATE_KEY_PATH" {
  default = "Files/devops1"
}

variable "PUBLIC_KEY_PATH" {
  default = "Files/devops1.pub"
}
variable "ssh_key_pair" {
  default = "devops2"
}
