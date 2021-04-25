variable "aws_region" {
  default = "us-east-1"
}

variable "rds_settings" {
  type = list(object({
    dbname     = string
    dbpass     = string
    dbusarname = string
  }))
  default = [
    {
      dbname     = "wp_db"
      dbpass     = "epam_pass"
      dbusarname = "wp_user"
    }
  ]
}
