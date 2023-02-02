resource "aws_lb_target_group" "AT-tg" {
  name     = "ALB-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id    =  var.vpc_id

  tags = {
    Name = "AT-tg"
  }
}