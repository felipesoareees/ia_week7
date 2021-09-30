resource "aws_lb" "test" {
  name               = "${var.cluster_name}-asg-test"
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.default.ids
  security_groups    = [aws_security_group.alb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.test.arn
  port              = local.http_port
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_lb_listener_rule" "asg" {
 listener_arn = aws_lb_listener.http.arn
 priority     = 100

 condition {
   path_pattern {
     values = ["*"]
   }
 }
 action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.asg.arn
 }
}
