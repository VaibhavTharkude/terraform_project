variable "region" {
    type = string
    description = "region calling"
}

variable "ami" {
    type = string
    description = "ami calling"
}

variable "instance_type" {
    type = string
    description = "instance_type calling"
}

# variable "key_name" {
#     type = string
#     description = "key_pair calling"
# }

variable "tags" {
    type = map
}

