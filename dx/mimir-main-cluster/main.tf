terraform {
  required_providers {
    aws = {
      version = ">= 3"
    }
  }
  required_version = ">= 1.8.3"

  backend "s3" {
    bucket = "9c-tfstates"
    key    = "dx-main"
    region = "us-east-2"
  }
}
