resource "aws_security_group" "devops_sg" {
  name        = "devops_sg"
  description = "Allow SSH, HTTP, and Docker Swarm ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "DevOps SG" }
}

resource "aws_instance" "swarm_nodes" {
  for_each        = toset(["manager"]) # 1 node
  
  # THIS IS THE NEW, VERIFIED AMI ID for Amazon Linux 2 in us-east-1
  ami             = "ami-021f4937d85adc5e2"
  
  instance_type   = "t2.micro" 
  key_name        = "sanju_key" 
  security_groups = [aws_security_group.devops_sg.name]
  tags            = { Name = each.key }
}

resource "aws_eip" "eips" {
  for_each = aws_instance.swarm_nodes
  instance = each.value.id
  tags     = { Name = "${each.key}-EIP" }
}