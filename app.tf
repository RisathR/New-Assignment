data "aws_ami" "app" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu1.id
  instance_type = "t2.micro"
  key_name      = "apache test"
  vpc_security_group_ids = [aws_security_group.public-sg.id]
  subnet_id = module.vpc.private_subnets[1]
 tags = {
    Name = "App"
  }
}
