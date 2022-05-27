variable "region" {
  type        = string
  description = "The AWS region to use"
  default     = "ap-south-1"
}

variable "bucket_prefix" {
  type        = string
  description = "The name of the S3 bucket to use"
  default     = "terraform-remote-backend-"
}

variable "table_name" {
  type        = string
  description = "The name of the DynamoDB table to use"
  default     = "terraform-state-lock"
}
  