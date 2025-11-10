output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "subnet_ids" {
  description = "A map of all subnet IDs"
  value       = { for k, s in aws_subnet.subnets : k => s.id }
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [
    for s in aws_subnet.subnets : s.id if s.tags["Type"] == "public"
  ]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [
    for s in aws_subnet.subnets : s.id if s.tags["Type"] == "private"
  ]
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_route_tables.id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private_route_tables.id
}
