resource "aws_security_group" "instance" {
  name = "${var.cluster_name}-test-instance"

  ingress{
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
 default = true
}

data "aws_subnet_ids" "default" {
 vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "alb" {
  name = "${var.cluster_name}-test-alb"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type = "ingress"
  security_group_id = aws_security_group.alb.id

  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}
resource "aws_security_group_rule" "allow_all_outbound" {
  type = "egress"  
  security_group_id = aws_security_group.alb.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
}
