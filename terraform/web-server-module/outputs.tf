output "instance_public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = [for instance in aws_instance.terraform-ec2 : instance.public_ip]
}

output "instance_dns_name" {
  description = "DNS names of the EC2 instances"
  value       = [for i in aws_instance.terraform-ec2 : i.public_dns]
}

output "private_ip" {
  description = "Private IPs of the EC2 instances"
  value       = aws_instance.terraform-ec2[*].private_ip
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.example_vpc.id
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = aws_subnet.example_subnet.id
}


output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.example.bucket
}

