output "public_subnet_ids" {
  description = "list of public subnet ids"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  description = "list of private subnet ids"
  value       = aws_subnet.private_subnets[*].id
}