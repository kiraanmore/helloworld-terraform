output "vpc-id" {
        value = aws_vpc.vpc.id
}

output "public-subnet-1-id" {
        value = aws_subnet.public-subnet-1.id
}

output "public-subnet-2-id" {
        value = aws_subnet.public-subnet-2.id
}

output "private-subnet-1-id" {
        value = aws_subnet.private-subnet-1.id
}

output "private-subnet-2-id" {
        value = aws_subnet.private-subnet-2.id
}

output "lb-sg-id" {
        value = aws_security_group.lb-sg.id
}

output "webserver-sg-id" {
        value = aws_security_group.webserver-sg.id
}

output "bastion-sg-id" {
        value = aws_security_group.bastion-sg.id
}