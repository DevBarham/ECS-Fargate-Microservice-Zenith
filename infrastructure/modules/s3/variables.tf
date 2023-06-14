variable "bucket_name" {
  description = "The name of your S3 bucket"
  type        = string
}

variable "public_s3" {
  description = "Set this variable to true if you want to create a public s3"
  type        = bool
  default     = false
}

