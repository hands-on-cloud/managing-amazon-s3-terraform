variable "region" {
  type        = string
  description = "The region to create/manage resources in"
  default     = "ap-south-1"
}

variable "bucket_prefix" {
  type        = string
  description = "The prefix to use for the S3 bucket name"
  default     = "tf-confidential"
}

variable "upload_source" {
  type        = string
  description = "The source file to upload"
  default     = "uploads/confidential.jpg"
}