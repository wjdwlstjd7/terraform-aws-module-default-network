variable "aws_default_region" {
  description = "사용하는 account default_region"
  type = string
}

variable "aws_access_key" {
  description = "사용하는 account access key"
  type = string
}

variable "aws_secret_key" {
  description = "사용하는 account secret key"
  type = string
}

variable "account_name" {
  description = "사용하는 account 이름"
  type = string
}

variable "csp" {
  description = "csp 코드"
  type = string
  default = "aws"
}

variable "env" {
  description = "배포 환경 이름"
  type = string
}

variable "owner" {
  description = "리소스 관리 주체 팀"
  type = string
  default = "datacenter"
}

variable "service_name" {
  description = "리소스에 의해 운영되는 서비스"
  type = string
}

variable "region" {
  description = "사용하는 리전"
  type = map(string)
  default = {
    an2 = "ap-northeast-2"
  }
}
variable "region_code" {
  description = "사용하는 리전 code"
  type = string
  default = "an2"
}
variable "azs" {
  description = "사용하는 가용영역"
  type = list(string)
  default = [
    "a",
    "b",
    "c",
    "d"]
}

variable "tags" {
  description = "리소스 태그"
  type = map(string)
  default = {
    map-migrated = "d-server-01167j6hmscqbn"
  }
}

# Network
variable "vpc_cidr" {
  type = string
  description = "VPC CIDR"
}

variable "public_subnet_cidr_list" {
  type = list(string)
  description = "생성될 VPC의 public subnet cidr 목록"
}

variable "ap_subnet_cidr_list" {
  type = list(string)
  description = "생성될 VPC의 ap subnet cidr 목록"
}
variable "db_subnet_cidr_list" {
  type = list(string)
  description = "생성될 VPC의 db subnet cidr 목록"
}

variable "attach_subnet_cidr_list" {
  type = list(string)
  description = "생성될 VPC의 attach subnet cidr 목록"
}

variable "create_default_vpc" {
  description = "default vpc 생성 여부"
  type = bool
}