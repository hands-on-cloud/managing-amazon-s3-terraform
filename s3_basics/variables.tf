variable "region" {
  type        = string
  description = "The region to create/manage resources in"
  default     = "ap-south-1"
}

variable "bucket_prefix" {
  type        = string
  description = "The prefix to use for the S3 bucket name"
  default     = "tf-bucket"
}

variable "key_name" {
  type        = string
  description = "The key name to use for the S3 object"
  default     = "tf-upload.jpg"
}

variable "source_path" {
  type        = string
  description = "The path to the file to upload to S3"
  default     = "dog.jpg"
}