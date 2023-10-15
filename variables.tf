# Input variable definitions

variable "region" {
  description = "AWS Region"
  type    = string
  default = "us-east-1"
}

variable "profile" {
  description = "AWS Profile"
  type    = string
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