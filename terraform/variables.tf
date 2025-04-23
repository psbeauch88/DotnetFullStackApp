variable "region" {
  default = "us-west-2"
}

variable "db_password" {
  description = "admin"
  sensitive   = true
}
