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