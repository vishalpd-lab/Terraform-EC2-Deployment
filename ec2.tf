#key pair
resource aws_key_pair my_key_pair {

key_name="terra-key-ec2"
public_key=file("terra-key-ec2.pub")
} 

#VPC
resource aws_default_vpc default {
}

# security group
resource aws_security_group my_security_group {

name="terra-security-group"
vpc_id= aws_default_vpc.default.id  # interpolation
description = "this is Inbound and outbound rules for your instance Security group"

}

# Inbound  port rules
resource aws_vpc_security_group_ingress_rule allow_http {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource aws_vpc_security_group_ingress_rule allow_ssh {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

#outbound port rules
resource aws_vpc_security_group_egress_rule allow_all_traffic {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#Ec2 instance

resource aws_instance my_instance {

	count = 2
	ami = "ami-0fe18bc3cfa53a248" # ububtu
    user_data = file("install_nginx.sh")
	instance_type = "t2.micro" # Instance Type

	key_name = aws_key_pair.my_key_pair.key_name	# Key pair

	vpc_security_group_ids = [aws_security_group.my_security_group.id] # VPC & Security Group
	
	# root storage (EBS)
	root_block_device {
		volume_size = 10
		volume_type = "gp3"
	}

	tags = {
    Name = "terra-automate-server"
  }
}
