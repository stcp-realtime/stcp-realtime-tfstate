# ---------------------------------------------------------------------------------------------------------------------
# General
# ---------------------------------------------------------------------------------------------------------------------\

variable "project_name" {
  description = "Name of the application."
  type        = string
}

variable "environment" {
  description = "Environment of the application."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Settings
# ---------------------------------------------------------------------------------------------------------------------

variable "aws_region" {
  description = "AWS Region to use for resources."
  type        = string
  default     = "eu-south-2"
}
