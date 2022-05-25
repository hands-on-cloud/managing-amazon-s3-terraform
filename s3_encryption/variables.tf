variable "region" {
  type        = string
  description = "The region to use for the S3 bucket"
  default     = "ap-south-1"
}

variable "bucket_prefix" {
  type        = string
  description = "The prefix to use for the S3 bucket"
  default     = "tf-sse-demo-"
}

variable "upload_source" {
  type        = string
  description = "The source file to upload to S3"
  default     = "uploads/file.txt"
  
}