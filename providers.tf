provider "aws" {
  profile = "default"
  region  = "us-east-2"
}


data "aws_availability_zones" "all" {}