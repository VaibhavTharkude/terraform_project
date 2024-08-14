terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.61.0"
        }
    }
}

provider "aws" {
    region = var.region
}



locals {
  map = {
    "HTTP" = {
      port = 80,
      cidr_blocks = ["0.0.0.0/0"],
    }
    "SSH" = {
      port = 22,
      cidr_blocks = ["10.0.0.0/16"],
    }
    "HTTPS" = {
      port = 443,
      cidr_blocks = ["0.0.0.0/0"],
    }
  }
}

resource "aws_security_group" "mysg" {
  name        = "webserver"
  description = "Inbound Rules for WebServer"

  dynamic "ingress" {
    for_each = local.map
    content {
      description = ingress.key
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}

resource "aws_key_pair" "my_key" {
    key_name = "terra_key"
    public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "this" {
    ami           = var.ami
    instance_type = var.instance_type
    key_name      = aws_key_pair.my_key.key_name
    vpc_security_group_ids = ["${aws_security_group.mysg.id}"]
    tags          = var.tags
}