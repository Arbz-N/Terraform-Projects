cidr_block = "10.0.0.0/16"
cidr_subnet-1 = "10.0.0.0/24"
cidr_subnet-2 = "10.0.1.0/24"
zone_subnet-1= "us-east-2a"
zone_subnet-2 = "us-east-2c"


sg_ingress_rules = {
  ssh = {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  http = {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

sg_egress_rules = {
  egress = {
    description = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
instance_type = {
  webserver1 = "t3.micro",
  webserver2 = "t3.micro"
}
instance_name = {
  webserver1 = "webserver1",
  webserver2 = "webserver2"
}
instance_ami = {
  webserver1 = "ami-0f5fcdfbd140e4ab7",
  webserver2 = "ami-0f5fcdfbd140e4ab7"
}
