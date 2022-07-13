terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
backend "s3" {
    bucket = "risath"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
provider "aws" {
  region = "us-east-1"
}
