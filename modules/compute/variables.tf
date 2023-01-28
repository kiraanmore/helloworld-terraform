variable "instance_type" {    
    type = string
}

variable "public_key_path" {
    type = string
}

variable "log-bucket-name" {
    type = string
}

variable "vpc-id" {
    type = string
}

variable "public-subnet-1-id" {
    type = string
}

variable "public-subnet-2-id" {
    type = string
}

variable "private-subnet-1-id" {
    type = string
}

variable "private-subnet-2-id" {
    type = string
}

variable "lb-sg-id" {
    type = string
}

variable "webserver-sg-id" {
    type = string
}

variable "bastion-sg-id" {
    type = string
}