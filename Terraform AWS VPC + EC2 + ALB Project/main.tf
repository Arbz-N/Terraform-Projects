resource "aws_vpc" "sample_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "sample_vpc"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.sample_vpc.id
  cidr_block = var.cidr_subnet-1
  availability_zone = var.zone_subnet-1
  map_public_ip_on_launch = true
  tags = {
    Name = "sample_subnet"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.sample_vpc.id
  cidr_block = var.cidr_subnet-2
  availability_zone = var.zone_subnet-2
  map_public_ip_on_launch = true
  tags = {
    Name = "sample_subnet"
  }
}

resource "aws_internet_gateway" "sample_igw" {
  vpc_id = aws_vpc.sample_vpc.id

  tags = {
    Name = "sample_igw"
  }
}

resource "aws_route_table" "sample_rt" {
  vpc_id = aws_vpc.sample_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sample_igw.id
  }

  tags = {
    Name = "sample_rt"
  }
}

locals {
  subnet_ids = {
    subnet1 = aws_subnet.subnet-1.id
    subnet2 = aws_subnet.subnet-2.id
  }
}

resource "aws_route_table_association" "assoc" {
  for_each = local.subnet_ids
  depends_on = [
    aws_subnet.subnet-1,
    aws_subnet.subnet-2
  ]

  subnet_id      = each.value
  route_table_id = aws_route_table.sample_rt.id
}

resource "aws_security_group" "sample_sg" {
  name        = "sample_sg"
  vpc_id      = aws_vpc.sample_vpc.id
}

resource "aws_security_group_rule" "ingress" {
  for_each = tomap(var.sg_ingress_rules)
  type = "ingress"
  security_group_id = aws_security_group.sample_sg.id

  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
}

resource "aws_security_group_rule" "egress" {
  for_each = tomap(var.sg_egress_rules)
  type = "egress"
  security_group_id = aws_security_group.sample_sg.id

  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
}

resource "aws_s3_bucket" "sample_bucket" {
  bucket = "<S3_BUCKET_NAME>"
}

resource "aws_key_pair" "sample_key" {
  key_name   = "<KEY_PAIR_NAME>"      # Example: terraform-key
  public_key = file("<PUBLIC_KEY>")   # Example: terraform-key.pub

}
resource "aws_instance" "webserver1" {
  ami = var.instance_ami.webserver1
  instance_type = var.instance_type.webserver1
  subnet_id = aws_subnet.subnet-1.id
  vpc_security_group_ids = [aws_security_group.sample_sg.id]
  key_name = aws_key_pair.sample_key.key_name
  user_data = file("userdata1.sh")
}
resource "aws_instance" "webserver2" {
  ami           = var.instance_ami.webserver2
  instance_type = var.instance_type.webserver2
  subnet_id     = aws_subnet.subnet-2.id
  vpc_security_group_ids = [aws_security_group.sample_sg.id]
  key_name = aws_key_pair.sample_key.key_name
  user_data = file("userdata2.sh")

}
resource "aws_lb" "sample_lb" {
  name               = "sample-lb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
  security_groups    = [aws_security_group.sample_sg.id]

  tags = {
    Name = "web"
  }
}

resource "aws_lb_target_group" "sample_tg" {
  name     = "sample-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.sample_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    port                = "traffic-port"
  }
}

locals {
  instances_id = {
    webserver1 = aws_instance.webserver1.id
    webserver2 = aws_instance.webserver2.id
  }
}

resource "aws_lb_target_group_attachment" "attach" {
  for_each = local.instances_id
  depends_on = [
    aws_instance.webserver1,
    aws_instance.webserver2
  ]

  target_group_arn = aws_lb_target_group.sample_tg.arn
  target_id        = each.value
}
resource "aws_lb_listener" "sample_lb_listener" {
  load_balancer_arn = aws_lb.sample_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sample_tg.arn
  }
}


