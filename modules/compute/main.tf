data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners = ["amazon"]

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm-*-x86_64-gp2"]
 }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_lb" "alb" {
  name               = "webserver-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb-sg-id]
  subnets            = [var.public-subnet-1-id, var.public-subnet-2-id]

  tags = {
    Name = "Webserver-alb"
  }
}

resource "aws_lb_target_group" "http-tg" {
  name     = "http-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.http-tg.arn
  }
}

resource "aws_launch_configuration" "webserver-lc" {
  name          = "webserver_launch_config"
  image_id      = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type
  key_name = aws_key_pair.ssh-key.key_name
  security_groups = ["${var.webserver-sg-id}", "${var.bastion-sg-id}"]
  user_data = <<EOF
          #! /bin/bash
          amazon-linux-extras install nginx1 -y
          systemctl start nginx
          systemctl enable nginx
          echo "Hello World" > /usr/share/nginx/html/index.html
  EOF
}

resource "aws_autoscaling_group" "webserver-asg" {
  desired_capacity   = 2
  max_size           = 4
  min_size           = 1
  launch_configuration = aws_launch_configuration.webserver-lc.name
  vpc_zone_identifier = [var.private-subnet-1-id, var.private-subnet-2-id]
  target_group_arns = ["${aws_lb_target_group.http-tg.arn}"]
}