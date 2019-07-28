
#variable "aws_access_key" {}
#variable "aws_secret_key" {}
variable "ecs_iam_role" {}

variable "ecs_cluster" {
  description = "ECS cluster name"
#  default = "ECS_cluster"
}


variable "region" {
  description = "AWS region"
#  default = "us-east-1"
}

variable "availability_zone" {
  description = "availability zone used for the demo, based on region"
  default = {
    us-east-1 = "us-east-1"
  }
}


variable "dockertag" {}

variable "ecs_target_group" {}
