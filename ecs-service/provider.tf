# Setup our aws provider
provider "aws" {
  region      = "${var.region}"
}


#provider "aws" {
#  access_key = "${var.aws_access_key}"
#  secret_key = "${var.aws_secret_key}"
#  region     = "${var.region}"
#}

