

output "vpc_id" {
    value = aws_vpc.my_vpc.id
    description = "the vpc id"
}

output "public_subnets_id" {
    value       = slice(aws_subnet.subnet[*].id, 0, 3)  # Extracting the list of public subnets Ids
    description = "the list of public subnet ids"
}

output "private_subnets_id" {
    value       = slice(aws_subnet.subnet[*].id, 3, 6)   # Extracting the list of private subnets Ids
    description = "the list of private subnet ids"
}

output "database_subnets_id" {
    value       = slice(aws_subnet.subnet[*].id, 6, 9)   # Extracting the list of database subnets Ids
    description = "the list of database subnet ids"
}

output "availability_zone" {
    value = slice(data.aws_availability_zones.my_az.names, 0, 3)
    description = "the list of availability_zone"
}

# Using two different methods to extract the subnets cidrs: slice() and cidrsubnet()
output "public_subnets_cidr" {
    value =  slice(aws_subnet.subnet[*].cidr_block, 0, 3)
    description = "the list of public subnet cidrs"
    # value      = [
    #   for i in range(0, 3):
    #     cidrsubnet(aws_vpc.my_vpc.cidr_block, 8, i)
    # ]
}

output "private_subnets_cidr" {
    value =  slice(aws_subnet.subnet[*].cidr_block, 3, 6)
    description = "the list of private subnet cidrs"
    # value      = [
    #   for i in range(3, 6):
    #     cidrsubnet(aws_vpc.my_vpc.cidr_block, 8, i)
    # ]
}

output "database_subnets_cidr" {
    value =  slice(aws_subnet.subnet[*].cidr_block, 6, 9)
    description = "the list of database subnet cidrs"
    # value      = [
    #   for i in range(6, 9):
    #     cidrsubnet(aws_vpc.my_vpc.cidr_block, 8, i)
    # ]
}
