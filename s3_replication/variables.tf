variable "src_region" {
  type        = string
  description = "The Source Bucket's region"
  default     = "us-east-1"
}

variable "dest_region" {
  type        = string
  description = "The Destination Bucket's region"
  default     = "us-west-2"
}

variable "src_bucket_prefix" {
  type        = string
  description = "The Source Bucket's prefix"
  default     = "tf-src-bucket"
}

variable "dest_bucket_prefix" {
  type        = string
  description = "The Destination Bucket's prefix"
  default     = "tf-dest-bucket"
}

variable "upload_path" {
  type        = string
  description = "The path to the file to upload"
  default     = "uploads/file.txt"
}