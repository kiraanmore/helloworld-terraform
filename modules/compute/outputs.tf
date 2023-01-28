output "amazon-linux-ami" {
        value = data.aws_ami.amazon-linux-2.id
}

output "load-balancer-endpoint" {
        value = aws_lb.alb.dns_name
}