data "aws_ami" "jenkins" {

  filter {
    name   = "jenkins"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.jenkins.id
  instance_type = "t2.medium"
  key_name      = "apache test"
  vpc_security_group_ids = [aws_security_group.private-sg.id]
  subnet_id = module.vpc.private_subnets[0]
 tags = {
    Name = "Jenkins"
  }
}
