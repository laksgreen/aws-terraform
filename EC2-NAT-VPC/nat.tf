## Nat GW
resource "aws_eip" "nat" {
  vpc = true
  tags {
    Name	= "myteam-eip"
  }
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id	= "${aws_eip.nat.id}"
  subnet_id	= "${aws_subnet.myteam-public-1.id}"
  depends_on	= ["aws_internet_gateway.myteam-gw"]
  tags {
    Name	= "myteam-NAT-GW"
  }
}

## Setup VPC for NAT
resource "aws_route_table" "myteam-private" {
  vpc_id	 	= "${aws_vpc.myteam-vpc.id}"
  route {
    cidr_block	 	= "0.0.0.0/0"
    nat_gateway_id 	= "${aws_nat_gateway.nat-gw.id}" 
  }
  tags {
    Name		= "myteam-private"
  }
}
## Route association private
resource "aws_route_table_association" "myteam-private-1a" {
  subnet_id 		= "${aws_subnet.myteam-private-1.id}"
  route_table_id 	= "${aws_route_table.myteam-rt.id}"
}
resource "aws_route_table_association" "myteam-private-2a" {
  subnet_id		= "${aws_subnet.myteam-private-2.id}"
  route_table_id	= "${aws_route_table.myteam-rt.id}"
}
resource "aws_route_table_association" "myteam-private-3a" {
  subnet_id		= "${aws_subnet.myteam-private-3.id}"
  route_table_id	= "${aws_route_table.myteam-rt.id}"
}
