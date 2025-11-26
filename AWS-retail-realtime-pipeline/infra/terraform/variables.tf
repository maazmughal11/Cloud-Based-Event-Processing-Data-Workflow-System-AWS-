variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "project_prefix" {
  type        = string
  default     = "retail-realtime-demo"
  description = "Prefix for naming AWS resources"
}
