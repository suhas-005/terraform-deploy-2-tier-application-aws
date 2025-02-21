resource "aws_lb" "web_alb" {
  name               = "application-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_sg]
  subnets            = [var.pub_sub1, var.pub_sub2]

  tags = {
    Name = "${var.project}-alb"
  }
}

resource "aws_lb_target_group" "web_target_grp" {
  name     = "web-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/wp-admin/setup-config.php"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 3
    unhealthy_threshold = 5
  }
}

resource "aws_lb_target_group_attachment" "web_target_grp_backend_1" {
  target_group_arn = aws_lb_target_group.web_target_grp.arn
  target_id        = var.web_ec2_1
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_target_grp_backend_2" {
  target_group_arn = aws_lb_target_group.web_target_grp.arn
  target_id        = var.web_ec2_2
  port             = 80
}

resource "aws_lb_listener" "web_alb_listener" {
  load_balancer_arn  = aws_lb.web_alb.arn
  port               = 80
  protocol           = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_target_grp.arn
  }
}