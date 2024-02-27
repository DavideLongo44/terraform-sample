provider "aws" {
  region = var.region

}
resource "aws_vpc" "example_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_vpc" "example_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}
resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id
}
resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }
}
resource "aws_route_table_association" "example_association" {
  subnet_id      = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.example_route_table.id
}
resource "aws_security_group" "example_security_group" {
  name        = "allow-ssh-http-https"
  description = "Allow SSH, HTTP, and HTTPS inbound traffic"
  vpc_id      = aws_vpc.example_vpc.id

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

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "terraform-ec2" {

  tags = {
    Name = "${var.environment}-web-server"
  }
  ami           = var.ami
  instance_type = "t2.micro"
  # wenn änderung kommen
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.example_subnet.id
  vpc_security_group_ids      = [aws_security_group.example_security_group.id]
  associate_public_ip_address = true
}
#resource "aws_db_subnet_group" "subnet_group" {
 # name       = "subnet_group"
 # subnet_ids = [aws_subnet.example_subnet.id]

 # tags = {
 #   Name = "banana"
 # }
#}
#data "aws_availability_zones" "available" {
 # state = "available"
#}
resource "aws_db_instance" "example_db_instance" {
  #db_subnet_group_name = data.aws_availability_zones.available.names
  identifier           = "${var.environment}-db-instance"
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "admin123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true #wichtiger Flag da er sonst, während des terraform destroy Prozesses, die Datenbank nicht löscht
  multi_az             = false
}

