# Please change the key_name and your config file 
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.57.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

variable "secgr-dynamic-ports" {
  default = [22,80,443]
}

variable "instance-type" {
  default = "t2.micro"
  sensitive = true
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  dynamic "ingress" {
    for_each = var.secgr-dynamic-ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

  egress {
    description = "Outbound Allowed"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bookstore-tf" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = var.instance-type
  key_name = "lastgaskinkey"
  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ]
  
      tags = {
      Name = "bookstore"
  }

  user_data = file("userdata.sh")
}  
