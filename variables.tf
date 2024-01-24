# Input variable definitions

variable "region" {
  description = "AWS Region"
  type    = string
  default = "us-east-1"
}

variable "application_name" {
  description = "Application Name"
  type    = string
}

variable "environment" {
  description = "Application Environment"
  type    = string
}

variable "owner_team" {
  description = "Application Owner Team"
  type    = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "db_storage" {
  description = "Database Storage"
  type    = number
  default = 20
}