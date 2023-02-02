resource "aws_security_group" "sg_instance" {
  name        = "sg_instance"
  description = "Allow TLS inbound traffic"
  vpc_id    =  var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      =  ["${var.vpc_cidr}"]
#ipv6_cidr_blocks = [aws_vpc.main.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [ "0.0.0.0/0" ]
   }

  tags = {
    Name = "sg_instance"
  }
}

output "sg-instance" {
    value = aws_security_group.sg_instance.id
}

resource "aws_security_group" "sg_alb" {
  name        = "sg_alb"
  description = "test"
  vpc_id    =  var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      =  ["${var.vpc_cidr}"]
#ipv6_cidr_blocks = [aws_vpc.main.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }

  tags = {
    Name = "sg_alb"
  }
}

output "sg-alb" {
    value = aws_security_group.sg_alb.id
}
