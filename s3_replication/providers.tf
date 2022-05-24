terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.15.1"
    }
  }
}

#source bucket provider
provider "aws" {
  alias  = "source"
  region = var.src_region
}

#destination bucket provider
provider "aws" {
  alias  = "destination"
  region = var.dest_region
}