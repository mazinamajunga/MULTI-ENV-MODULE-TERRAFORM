resource "aws_launch_template" "asg_webserver" {
  name = var.name 
  image_id = var.image_id  
  instance_type = var.instance_type   
  metadata_options {     # restricting Instance metadata service to be interacted with freely.
    http_tokens = "required"
  }  
  key_name = var.key_name   
  monitoring {
    enabled = var.monitoring    
  }
  placement {
    availability_zone = var.availability_zone   
  }
  vpc_security_group_ids = [aws_security_group.asg_security_group.id] 
  tag_specifications {
    resource_type = var.resource_type       
    tags = {
      Name = "${var.name}" # Tag attached to the newly created instance from ASG.
    }
  }
}

resource "aws_autoscaling_group" "asg_webserver" {
  name = "asg_webserver"
  desired_capacity   = var.desired_capacity  
  max_size           = var.max_size 
  min_size           = var.min_size 
  vpc_zone_identifier = var.zone_identifier         
  launch_template {
    id      = aws_launch_template.asg_webserver.id
    version = "$Latest"
  }
}

resource "aws_security_group" "asg_security_group" {
  name        = "Dev_Env_SG"
  description = "Allow inbound traffic"
  vpc_id = var.vpc_id
  ingress {
    description      = "traffic from internet"
    from_port        = var.http_ingress_port
    to_port          = var.http_ingress_port
    protocol         = var.protocol
    cidr_blocks      = [var.internet_cidr] # tfsec:ignore:aws-ec2-no-public-ingress-sgr
  }
  ingress {
    description      = "traffic from VPC"
    from_port        = var.ssh_ingress_port
    to_port          = var.ssh_ingress_port
    protocol         = var.protocol
    cidr_blocks      = [var.internet_cidr] # tfsec:ignore:aws-ec2-no-public-ingress-sgr
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.internet_cidr] # tfsec:ignore:aws-ec2-no-public-egress-sgr
  }
  tags = {
    Name = "Dev_Env_SG"
  }
}