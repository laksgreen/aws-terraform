## Defind an AWS provider with credentaials
provider "aws" {
shared_credentials_file = "~/.aws/credentials"
  region     = "${var.AWS_REGION}"
}
