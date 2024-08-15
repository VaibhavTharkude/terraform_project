provider "aws" {
    region = var.region
}

terraform {
   backend "s3" {
       bucket = "terraform-state-bucket-cdec-vaibhav1"
       key = "terraform.tfstate"
       region = "ap-south-1"
       dynamodb_table = "terraform_state_lock"
    }
}