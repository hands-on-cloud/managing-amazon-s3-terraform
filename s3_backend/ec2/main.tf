#fetching VPC state data from s3 bucket:
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-remote-backend-20220527093846103400000001"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

#fetch latest Ubuntu AMI:
data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

#create two EC2 instances using the AMI:
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["0", "1"])

  name = "instance-${each.key}"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = data.terraform_remote_state.vpc.outputs.sg_ids
  subnet_id              = data.terraform_remote_state.vpc.outputs.subnet_ids[each.key]

  tags = {
    Project = "hands-on.cloud"
  }
}