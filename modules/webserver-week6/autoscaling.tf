resource "aws_autoscaling_group" "test" {
  launch_configuration =  aws_launch_configuration.test.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_size

  tag {
    key                 = "Name"
    value               = "var.cluster_name"
    propagate_at_launch = true
  }

}

resource "aws_lb_target_group" "asg" {
  name     = "${var.cluster_name}-asm-test"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id


  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

}
