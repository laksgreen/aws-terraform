






## AWS aws_region
variable "AWS_us-east-1" {
#  default = "REGION"
}

variable "INSTANCE_USERNAME" {
#  default = "ubuntu"
}
variable "myteam-vpc" {}
variable "public-subnets" {}
## AMIs for all the regions which you want to use
variable "AMIS" {
 type = map(string)

  default = {
    ${us-east-1} = "ami-06f2f779464715dc5"
    us-east-1 = "ami-0ac019f4fcb7cb7e6"
  }
}

## SSH-Access-key pair
variable "PRIVATE_KEY_PATH" {
#  default = "Files/devops1"
}

variable "PUBLIC_KEY_PATH" {
#  default = "Files/devops1.pub"
}

variable "ssh_key_pair" {
#  default = "devops1"
}

