#required outputs for EC2 instances:

output "subnet_ids" {
  value       = module.vpc.public_subnets
  description = "VPC public subnets' IDs list"
}

output "sg_ids" {
  value       = [module.web_server_sg.security_group_id]
  description = "Security Group ID"
  
}