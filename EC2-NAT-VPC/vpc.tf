## Internet VPC
resource "aws_vpc" "myteam-vpc" {
  cidr_block 		= "172.30.0.0/16"
  instance_tenancy 	= "default"
  enable_dns_support	= "true"
  enable_dns_hostnames	= "true"
  enable_classiclink	= "false"
  tags {
    Name		= "myteam-vpc"
  }
}
## Public Subnets
resource "aws_subnet" "myteam-public-1" {
  vpc_id 		  = "${aws_vpc.myteam-vpc.id}"
  cidr_block 		  = "172.30.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone	  = "${var.AWS_REGION}a"
  tags {
    Name		  = "myteam-public-1"
  }
}
resource "aws_subnet" "myteam-public-2" {
  vpc_id 		  = "${aws_vpc.myteam-vpc.id}"
  cidr_block		  = "172.30.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone	  = "${var.AWS_REGION}b"
  tags {
    Name		  = "myteam-public-2"
  }
}
resource "aws_subnet" "myteam-public-3" {
  vpc_id 		  = "${aws_vpc.myteam-vpc.id}"
  cidr_block		  = "172.30.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone	  = "${var.AWS_REGION}c"
  tags {
    Name		  = "myteam-public-3"
  }
}
## Private-Subnets
resource "aws_subnet" "myteam-private-1" {
  vpc_id 		  = "${aws_vpc.myteam-vpc.id}"
  cidr_block		  = "172.30.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone	  = "${var.AWS_REGION}a"
  tags {
    Name		  = "myteam-private-1"
  }
}
resource "aws_subnet" "myteam-private-2" {
  vpc_id 		  = "${aws_vpc.myteam-vpc.id}"
  cidr_block		  = "172.30.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone	  = "${var.AWS_REGION}b"
  tags {
    Name		  = "myteam-private-2"
  }
}

resource "aws_subnet" "myteam-private-3" {
  vpc_id 		  = "${aws_vpc.myteam-vpc.id}"
  cidr_block		  = "172.30.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone	  = "${var.AWS_REGION}c"
  tags {
    Name		  = "myteam-private-3"
  }
}
## IGW
resource "aws_internet_gateway" "myteam-gw" {
  vpc_id 		  = "${aws_vpc.myteam-vpc.id}"
  tags {
    Name		  = "myteam-gw"
  }
}

## Route Tables
resource "aws_route_table" "myteam-rt" {
  vpc_id 		  = "${aws_vpc.myteam-vpc.id}"
  route {
    cidr_block 		  = "0.0.0.0/0"
    gateway_id		  = "${aws_internet_gateway.myteam-gw.id}"
  }
  tags {
    Name		  = "myteam-rt"
  }
}

## Route associations public
resource "aws_route_table_association" "myteam-public-ip-1a" {
  subnet_id 		  = "${aws_subnet.myteam-public-1.id}"
  route_table_id	  = "${aws_route_table.myteam-rt.id}"
}
resource "aws_route_table_association" "myteam-public-ip-2a" {
  subnet_id		  = "${aws_subnet.myteam-public-2.id}"
  route_table_id	  = "${aws_route_table.myteam-rt.id}"
}
resource "aws_route_table_association" "myteam-public-ip-3a" {
  subnet_id 		  = "${aws_subnet.myteam-public-3.id}"
  route_table_id	  = "${aws_route_table.myteam-rt.id}"
}
