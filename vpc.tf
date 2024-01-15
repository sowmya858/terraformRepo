resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "prod_VPC"
  }
}

# create internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = " Prod_IGW"
  }
}

# Route table
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "prod_pub_rt"
  }
}

resource "aws_route_table" "pvt_rt" {
  vpc_id = aws_vpc.main.id

  route  = [ ]
    
 

  tags = {
    Name = "prod_pvt_rt"
  }
}
# create subnet
resource "aws_subnet" "publicsub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "prodpubsb"
  }
}

resource "aws_subnet" "privatesub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "prodpvtsb"
  }
}
# associate subnet with routetable

resource "aws_route_table_association" "associate_pubsubnt-RT" {
  subnet_id      = aws_subnet.publicsub.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "associate_pvtsubnt-RT" {
  subnet_id      = aws_subnet.privatesub.id
  route_table_id = aws_route_table.pvt_rt.id
}

  # Create secutiry groups 
  
  resource "aws_security_group" "SG" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  tags = {
    Name = "securitygrup"
  }
}














