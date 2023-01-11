provider "aws" {
  profile = "deekshith_aws"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "dees3devops"
    key    = "module.tfstate"
    region = "us-east-1"
  }
}