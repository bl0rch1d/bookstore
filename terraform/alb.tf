resource "aws_lb" "bookstore_staging_alb" {
  name               = "bookstore-staging-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.bookstore_staging_alb_sg.id}"]
  subnets            = ["${aws_default_subnet.default_az1.id}", "${aws_default_subnet.default_az2.id}", "${aws_default_subnet.default_az3.id}"]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "bookstore_staging_tg" {
  name        = "bookstore-staging-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_default_vpc.default.id
  target_type = "instance"

  health_check {
    enabled             = "true"
    interval            = 30
    protocol            = "HTTP"
    path                = "/health_check/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
  }

  depends_on = [aws_lb.bookstore_staging_alb]
}

resource "aws_lb_listener" "bookstore_alb_listener_web" {
  load_balancer_arn = aws_lb.bookstore_staging_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bookstore_staging_tg.arn
  }
}

resource "aws_lb_listener" "bookstore_alb_listener_app" {
  load_balancer_arn = aws_lb.bookstore_staging_alb.arn
  port              = "3000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bookstore_staging_tg.arn
  }
}
