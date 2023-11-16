# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket    = "terraform-remote-state-os"
    key       = "jupiter-website-ecs.tfstate"
    region    = "eu-west-2"
    profile   = "os-mfa"
  }
}