# AWS Moudle Network 구성


## 주요 버전

**_※ 프로젝트 주요버전을 따른다._**

**Terraform Version:** `1.0.7`

**aws provider:** `3.55.0`

## 주요 자원

- main VPC (_not rosa vpc_)
- default nacl, default security group
- public subnets, ap subnets, db subnets, tgw attachment subnets
- route tables 
- s3 endpoint

# Module Versions

**Latest Version:** `4.0.0`
> 모듈을 사용할 때, 다음의 변수의 값을 할당하여 aws credentials를 주입한다.
>
> _해당 credentials은 terraform 공통 workspace를 통해 Terraform cloud 내에서 암호화하여 전달된다._
> 
> - aws_default_region
> - aws_access_key
> - aws_secret_key

## Variables

| Variable | Meaning |
| :------- | :----- |
| `csp`| csp 코드 |
| `account_name`| 사용하는 account 이름 |
| `aws_default_region`| 사용하는 account default_region |
| `aws_access_key`| 사용하는 aws_access_key |
| `aws_secret_key`| 사용하는 aws_secret_key |
| `env` | 배포 환경 이름|
| `owner` | 리소스 관리 주체 팀 |
| `service_name` | 리소스에 의해 운영되는 서비스 |
| `vpc_subnet` | VPC CIDR block to use for the VPC |
| `region` | 사용하는 리전 |
| `region_code` | 사용하는 리전 code |
| `tags` | 리소스 태그 |
| `vpc_cidr` | VPC cidr |
| `public_subnet_cidr_list`| 생성될 VPC의 public subnet cidr 목록 |
| `ap_subnet_cidr_list`| 생성될 VPC의 ap subnet cidr 목록 |
| `db_subnet_cidr_list`| 생성될 VPC의 db subnet cidr 목록 |
| `attach_subnet_cidr_list`| 생성될 VPC의 attach subnet cidr 목록 |

## Outputs

| Outputs | Meaning |
| :------- | :----- |
| `vpc_cidr`| vpc cidr |
| `create_single_az` | single az 사용 여부 |
| `used_azs` | 리소스 관리 주체 팀 |
| `subnet_ids` | 사용 중인 az 영역 |
| `vpc_subnet` | 전체 subnet id 목록 |
| `public_subnet_cidr_list`| 생성될 VPC의 public subnet cidr 목록 |
| `ap_subnet_cidr_list`| 생성될 VPC의 ap subnet cidr 목록 |
| `db_subnet_cidr_list`| 생성될 VPC의 db subnet cidr 목록 |
| `attach_subnet_cidr_list`| 생성될 VPC의 attach subnet cidr 목록 |
| `private_route_table` | private route table 목록 |
| `public_route_table` | public route table 목록 |


## Usage

# Simple Example

* 모듈을 사용하는 방법의 예입니다.

```
module "module-comm-network" {
  source  = "app.terraform.io/kyobobook/module-comm-network/aws"
  version = "4.0.1"  
  
  aws_default_region = data.terraform_remote_state.global.outputs.default_region
  aws_access_key = local.account_keys.access
  aws_secret_key = local.account_keys.secret
  
  vpc_cidr  = "10.0.0.0/16"
  public_subnet_cidr_list = ["10.0.1.0/24"]
  ap_subnet_cidr_list = ["10.0.2.0/24"]
  db_subnet_cidr_list = ["10.0.3.0/24"]
  attach_subnet_cidr_list = ["10.0.4.0/24"]
}
```