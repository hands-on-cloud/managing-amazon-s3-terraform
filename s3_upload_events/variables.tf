variable "region" {
  type        = string
  description = "The region to use for the S3 bucket"
  default     = "ap-south-1"
}

variable "bucket_prefix" {
  type        = string
  description = "The prefix to use for the S3 bucket"
  default     = "tf-s3-events-demo-"
}