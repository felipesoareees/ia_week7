# If you use a instance.tf file, uncomment this lines.
#output "public_ip" {
#  value       = aws_instance.test.public_ip
#  description = "The public IP to access of the web server"
#}

output "alb_dns_name" {
 value       = aws_lb.test.dns_name
 description = "The domain name of the load balancer"
}

output "asg_name" {
 value = aws_autoscaling_group.test.name
 description = "The name of the Auto Scaling Group"
}

output "alb_security_group_id" {
 value = aws_security_group.alb.id
 description = "The ID of the Security Group attached to the load balancer"
}

