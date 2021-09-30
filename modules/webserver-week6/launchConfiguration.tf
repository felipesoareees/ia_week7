resource "aws_launch_configuration" "test" {
  image_id        = "ami-ID"
  instance_type   = var.instance_type
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World . The machine right now is $HOSTNAME" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  lifecycle {
    create_before_destroy = true
  }

}
