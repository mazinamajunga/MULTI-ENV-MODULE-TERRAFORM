data "aws_availability_zones" "my_az" {
  state = "available"
}

resource "random_integer" "tag" {
  min = 1
  max = 5000
}

resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr     
  enable_dns_support = var.dns_support     
  enable_dns_hostnames = var.dns_hostnames 
  tags = {
    Name = "Dev_Env_Vpc_${random_integer.tag.id}"
  }
}

resource "aws_subnet" "subnet" {
  count = var.my_count   # number of subnets to be created
  vpc_id     = aws_vpc.my_vpc.id  # ID of the VPC where the subnet will be created.
  cidr_block = cidrsubnet(var.vpc_cidr , 8, count.index)
  # The availability zone where the subnet will be created. 
  # The subnets are evenly distributed across the available zones 1a, 1b. 1c.
  availability_zone = (count.index < 3 ? 
  element(data.aws_availability_zones.my_az.names, count.index) : 
  count.index < 6 ? element(data.aws_availability_zones.my_az.names, count.index - 3) : 
  element(data.aws_availability_zones.my_az.names, count.index - 6))
  # Indicates whether instances launched in this subnet should be assigned a public IP address or not.
  map_public_ip_on_launch = count.index < 3 ? true : false # tfsec:ignore:aws-ec2-no-public-ip-subnet
  tags = {
    Name = (count.index < 3
      ? "Dev_Env_Pub_Sub${count.index + 1}_${random_integer.tag.id}"
      : count.index < 6
          ? "Dev_Env_Priv_Sub${count.index - 2}_${random_integer.tag.id}"
          : "Dev_Env_DataBase_Sub${count.index - 5}_${random_integer.tag.id}")
  }
}

# THIS RESOURCE ALONE WILL CREATE AND ATTACHED THE IGW TO THE VPC
# SO, THERE IS NO NEED TO CREATE A GW ATTACHMENT
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "my_igw_${random_integer.tag.id}"
    }
}

resource "aws_route_table" "my_public_route" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "public-rtb_${random_integer.tag.id}"
  }
  route {
    cidr_block = var.internet_cidr                     
    gateway_id = aws_internet_gateway.my_igw.id                            
  }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "pub_sub1_rta" {
  # Retriving the first public subnet id.
  subnet_id      = element(aws_subnet.subnet[*].id, 0)             # retrieving the first public subnet ID.
  route_table_id = aws_route_table.my_public_route.id              # and associating it with public rtb
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "pub_sub2_rta" {
  # Retriving the second public subnet id.
  subnet_id      = element(aws_subnet.subnet[*].id, 1)             # retrieving the second public subnet ID.
  route_table_id = aws_route_table.my_public_route.id              # and associating it with public rtb
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "pub_sub3_rta" {
  # Retriving the third public subnet id.
  subnet_id      = element(aws_subnet.subnet[*].id, 2)             # retrieving the third public subnet ID. 
  route_table_id = aws_route_table.my_public_route.id              # and associating it with public rtb
}

resource "aws_route_table" "my_route" {
  vpc_id = aws_vpc.my_vpc.id
  count = var.private_count
  tags = {
    Name = (count.index < 3 ? "private_rtb_${count.index + 1}" 
      : "DataBase_rtb_${count.index - 2}_${random_integer.tag.id}")
  }
}

resource "aws_route_table_association" "private_association" {
  count          = var.priv_assoc_count
  subnet_id      = aws_subnet.subnet[count.index + 3].id
  route_table_id = aws_route_table.my_route[count.index].id
}

resource "aws_route_table_association" "db_association" {
  count          = var.priv_assoc_count
  subnet_id      = aws_subnet.subnet[count.index + 6].id
  route_table_id = aws_route_table.my_route[count.index + 3].id
}
















