module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  
  name = "simple-example"

  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  

  enable_ipv6 = false

  enable_nat_gateway = true
  single_nat_gateway = true

 tags = {
    Owner       = "gaurav"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "rancher-vpc"
  }
}

