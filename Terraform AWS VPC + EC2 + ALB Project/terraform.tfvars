cidr_block = "<VPC_CIDR>"                # Example: 10.0.0.0/16
cidr_subnet-1 = "<SUBNET_CIDR_1>"        # Example: 10.0.0.0/24
cidr_subnet-2 = "<SUBNET_CIDR_2>"        # Example: 10.0.1.0/24
zone_subnet-1 = "<AZ_1>"                 # Example: us-east-2a
zone_subnet-2 = "<AZ_2>"                 # Example: us-east-2c


sg_ingress_rules = {
  ssh = {
    description = "<INGRESS_RULE_NAME_1>"    # Example: ssh
    from_port   = <SSH_FROM_PORT>            # Example: 22
    to_port     = <SSH_TO_PORT>              # Example: 22
    protocol    = "<SSH_PROTOCOL>"           # Example: tcp
    cidr_blocks = ["<SSH_CIDR>"]             # Example: 0.0.0.0/0
  }
  http = {
    description = "<INGRESS_RULE_NAME_2>"    # Example: http
    from_port   = <HTTP_FROM_PORT>           # Example: 80
    to_port     = <HTTP_TO_PORT>             # Example: 80
    protocol    = "<HTTP_PROTOCOL>"          # Example: tcp
    cidr_blocks = ["<HTTP_CIDR>"]            # Example: 0.0.0.0/0
  }
}

sg_egress_rules = {
  egress = {
    description = "<EGRESS_RULE_NAME>"       # Example: egress
    from_port   = <EGRESS_FROM_PORT>         # Example: 0
    to_port     = <EGRESS_TO_PORT>           # Example: 0
    protocol    = "<EGRESS_PROTOCOL>"        # Example: -1
    cidr_blocks = ["<EGRESS_CIDR>"]          # Example: 0.0.0.0/0
  }
}

instance_type = {
  webserver1 = "<INSTANCE_TYPE_1>",          # Example: t3.micro
  webserver2 = "<INSTANCE_TYPE_2>"           # Example: t3.micro
}

instance_name = {
  webserver1 = "<INSTANCE_NAME_1>",          # Example: webserver1
  webserver2 = "<INSTANCE_NAME_2>"           # Example: webserver2
}

instance_ami = {
  webserver1 = "<AMI_ID_1>",                 # Example: ami-xxxxxxxx
  webserver2 = "<AMI_ID_2>"                  # Example: ami-xxxxxxxx
}

