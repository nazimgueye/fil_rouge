terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "fil-rouge"
  public_key = file("public-key.pub")
}

resource "aws_instance" "app_server" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  key_name        = aws_key_pair.deployer.key_name

  tags = {
    Name = "fil-rouge"
  }
}

