variable "region" {
  type = string
  default = "ap-northeast-2"
}

variable "azs" {
  type = list(string)
  default = ["a","c"]
}
variable "public_subnet" {
  type = any
  default = {
    count = 2,
    cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  }
}

variable "private_subnet" {
  type = any
  default = {
    count = 2,
    cidr = ["10.0.11.0/24", "10.0.12.0/24"]
  }
}

variable "database_subnet" {
  type = any
  default = {
    count = 2,
    cidr = ["10.0.21.0/24", "10.0.22.0/24"]
  }
}