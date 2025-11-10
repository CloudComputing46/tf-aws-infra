variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Name of the project"
  type        = string
  default     = "my-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public            = bool
  }))
  default = {
    public-1 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      public            = true
    }
    public-2 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
      public            = true
    }
    public-3 = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1c"
      public            = true
    }
    private-1 = {
      cidr_block        = "10.0.101.0/24"
      availability_zone = "us-east-1a"
      public            = false
    }
    private-2 = {
      cidr_block        = "10.0.102.0/24"
      availability_zone = "us-east-1b"
      public            = false
    }
    private-3 = {
      cidr_block        = "10.0.103.0/24"
      availability_zone = "us-east-1c"
      public            = false
    }
  }
}

variable "internet_cidr_block" {
  description = "CIDR block for the internet"
  type        = string
  default     = "0.0.0.0/0"
}