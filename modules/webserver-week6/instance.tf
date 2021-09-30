#resource "aws_instance" "test" {
#  ami                    = "ami-ID"
#  instance_type          = "t2.micro"
#  vpc_security_group_ids = [aws_security_group.instance.id]
#
#  user_data = <<-EOF
#              #!/bin/bash
#              echo "Hello, World $HOSTNAME" > index.html
#              nohup busybox httpd -f -p 8080 &
#              EOF
#  tags = {
#    Name = "terraform-test"
#  }
#
#}
