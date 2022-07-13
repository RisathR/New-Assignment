data "http" "icanhazip" {
   url = "http://icanhazip.com"
}
resource "aws_security_group" "bastion" {
name = "bastion-sg"
vpc_id = module.vpc.vpc_id
ingress {
    cidr_blocks = ["${chomp(data.http.icanhazip.body)}/32"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
ingress {
   cidr_blocks = ["0.0.0.0/0"]
   from_port = 22
   to_port = 22
   protocol = "tcp"
  }
egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}
