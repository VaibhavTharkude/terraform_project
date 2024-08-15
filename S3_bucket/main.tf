resource "aws_s3_bucket" "terraform-state" {
    bucket = "terraform-state-bucket-cdec-vaibhav"
}

resource "aws_s3_bucket_versioning" "terraform-state" {
    bucket = aws_s3_bucket.terraform-state.id
    versioning_configuration {
        status = "Enabled"
        # force_destroy = true
    }
}

resource "aws_dynamodb_table" "state_lock_table" {
    name = "terraform_state_lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}

resource "aws_instance" "server_1" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    key_name = "terra_key"
    tags = var.tags
}
