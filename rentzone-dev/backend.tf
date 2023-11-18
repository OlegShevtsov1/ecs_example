# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-os"
    key            = "rentzone-dev/terraform.tfstate"
    region         = "eu-west-2"
    profile        = "os-mfa"
    dynamodb_table = "terraform-state-lock-os"
  }
}

# terraform {
#   backend "s3" {
#     bucket         = var.backend_s3_bucket
#     key            = var.tfstate_key
#     region         = var.region
#     profile        = var.profile
#     dynamodb_table = var.dynamodb_table
#   }
# }