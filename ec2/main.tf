










provider "aws" {
  region = "${var.AWS_REGION}"
}
## terraform s3
terraform {
  backend "s3" {}
}
