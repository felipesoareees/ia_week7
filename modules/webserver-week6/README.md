# ia_week6
Deploy a infrastructure AWS with ASG, LB,etc using terraform.

# AWS and Cloud compute
Assuming you understand the definition of cloud computing, we'll apply some features of EC2 (Amazon Cloud compute) via terraform

# IAC (Infrastrucute as Code)

With the advent of cloud computing, a new definition of infrastructure emerged: The possibility of provisioning infrastructure on demand and in an automated way through scripts (whether declarative or procedural). The IAC (infrastructure as code) gives us the possibility of building a cloud infrastructure (starting from the concept of immutability). Unlike on-premises company servers, where large teams are needed to maintain the data center, cloud computing gains traction and use with IAC.

![image](https://user-images.githubusercontent.com/83301821/134515736-aab1b867-a8ad-4477-abb4-9e8607a8cc5c.png)

Through yaml files, we were able to define the desirable state of our infrastructure.

The IAC is divided into 5 main pillars of possibility of action:

(i) AD-HOC scripts
It is possible to use commands for simple tasks which can be entered in a script that does small provisioning tasks. It's not the ideal use, but it's a possibility for simple tasks and tests from the command line.

(ii) Configuration Management tools

(iii) server templating tools
There are several tools on the market for the purpose of provisioning the created infrastructure. Thus, using IAC you can automate large-scale application configuration processes. One tool used for this purpose is Ansible.

(iv) orchestration tools
After the application is in production, it is necessary to do the administration of the provisioned resources. There are some tools for this: Kubernetes and Nomad.

(v) provisioning tools

It is at this stage of action that all cloud infrastructure is created. It is at this stage that the infrastructure is seen as really code. Thus, we have a yaml file that will define which infrastructure state you want to implement. For this pillar, the well-known tool is Terraform.

- What is Terraform?
It is a tool that we will use to deploy infrastructure, this fits into a provisioning tool. With it we will apply several AWS resources using just one computer with internet and one AWS account.

# Appling any resources AWS in terraform

- Create a EC2 instance

First, we will create a security group and define a variable called server_port:

``` variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

resource "aws_security_group" "instance" {
  name = "terraform-test-instance"

  ingress{
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

```

Following the sequence's file, below we have a create of a ec2 instante:

```resource "aws_instance" "test" {
  ami                     = "ami-ID"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World $HOSTNAME" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "terraform-test"
  }

}
```
After this, just apply to create a infrastructure (In this step, we assume that you already have an aws account set up with the necessary credentials to deploy the aforementioned features).

In the field `user_data` we declare a shell script that print hello word in a web server apache by default in the port 8080. This is to generate a endpoint `localhost:8080` that print hello word message.

- Creating a load balance with autoscaling group

In the file main.tf (tf is a extension of terraform file) there are whole provisioning of a infrastructure that we wish deploy. 

We can use :  `terraform apply` after of `terraform init`.
