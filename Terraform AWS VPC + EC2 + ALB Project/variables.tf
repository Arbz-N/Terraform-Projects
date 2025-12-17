variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "cidr_subnet-1" {
  description = "CIDR block for the subnet"
  type        = string
}
variable "cidr_subnet-2" {
  description = "CIDR block for the subnet"
  type        = string
}
variable "zone_subnet-1" {
  description = "Availability zone for the subnet"
  type        = string
}
variable "zone_subnet-2" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "sg_ingress_rules" {
  description = "Security group ingress rules"
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "sg_egress_rules" {
  description = "Security group egress rules"
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "instance_type" {
  description = "Instances type for the EC2 instance"
  type        = map(string)
}

variable "instance_ami" {
  description = "AMI for the EC2 instance"
  type        = map(string)
}
variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = map(string)
}





