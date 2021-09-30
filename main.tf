provider "aws" {
 region = "us-east-2"
}

module "webserver" {
# source = "./modules/webserver-week6"
  source = "github.com/felipesoareees/ia_week7//modules/webserver-week6?ref=v0.0.1"
  cluster_name = "web-server-dev"
 
 instance_type = "t2.micro"
 min_size = 1
 max_size = 3
 desired_size = 2
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
 scheduled_action_name = "scale-out-during-business-hours"
 min_size = 2
 max_size = 4
 desired_capacity = 3
 recurrence = "0 9 * * *"

 autoscaling_group_name = module.webserver.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
 scheduled_action_name = "scale-in-at-night"
 min_size = 1
 max_size = 4
 desired_capacity = 2
 recurrence = "0 17 * * *"

 autoscaling_group_name = module.webserver.asg_name
}

