## VPC outputs:

output "vpc_id" {
  value = aws_vpc.myVPC.id
}

output "public_subnet_1" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2" {
  value = aws_subnet.public_subnet_2.id
}

output "private_subnet_1" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2" {
  value = aws_subnet.private_subnet_2.id
}

output "private_subnet_3" {
  value = aws_subnet.private_subnet_3.id
}

output "private_subnet_4" {
  value = aws_subnet.private_subnet_4.id
}

output "Internet_gateway_id" {
  value = aws_internet_gateway.myIGW.id
}
