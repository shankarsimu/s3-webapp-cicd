variable "aws_region" {
  description = "AWS region used for the S3 bucket"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for AWS resources"
  type        = string
  default     = "shankar-devops-portfolio"
}
