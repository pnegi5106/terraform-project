
provider "aws" {
region = "ap-south-1"
}

resource "aws_instance" "one" {
  ami             = "ami-07b69f62c1d38b012"
  instance_type   = "t2.micro"
  key_name        = "terraformkey"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by prashant sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-07b69f62c1d38b012"
  instance_type   = "t2.micro"
  key_name        = "terraformkey"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by prashant sir server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-07b69f62c1d38b012"
  instance_type   = "t2.micro"
  key_name        = "terraformkey"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1a"
  tags = {
    Name = "server-3"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-07b69f62c1d38b012"
  instance_type   = "t2.micro"
  key_name        = "terraformkey"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1b"
  tags = {
    Name = "server-4"
  }
}

resource "aws_security_group" "five" {
  name = "elb-sg23"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "six" {
  bucket = "demo"
}

resource "aws_iam_user" "seven" {
for_each = var.user_names
name = each.value
}

variable "user_names" {
description = "*"
type = set(string)
default = ["u1", "u2"]
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "ap-south-1a"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
