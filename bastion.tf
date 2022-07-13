data "aws_ami" "bastion" {
  most_recent = true

  filter {
    name   = "bastion"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "apache test"
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id = module.vpc.public_subnets[0]
  tags = {
    Name = "Bastion"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.bastion.id
  vpc      = true
}
