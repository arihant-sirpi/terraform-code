resource "aws_lb" "ALB" {
  name               = "AT-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [ "${var.sg-alb}" ]
  subnets = ["${var.pub1_sub}", "${var.pub2_sub}"]
  enable_deletion_protection = false

  tags = {
    Environment = "test"
  }
}