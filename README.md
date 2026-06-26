# easy-net

基于 [Terraform](https://www.terraform.io/) 与火山引擎 Cloud Control Provider（`volcengine/volcenginecc`）的基础设施即代码（IaC）项目，用于在火山引擎上创建一个 VPC（私有网络）及其下属的一个 Subnet（子网）。

## 项目文件结构

项目遵循 Terraform 推荐的标准结构，将配置按职责拆分到不同文件中：

```
easy-net/
├── provider.tf      # 声明 Terraform 与 Provider（来源、认证、region）
├── variables.tf     # 声明输入变量（VPC / Subnet / 标签等可配置项）
├── main.tf          # 核心资源定义（VPC、Subnet）
├── outputs.tf       # 声明输出变量（资源创建后导出的属性）
├── .gitignore       # 忽略 state、lock、密钥等文件
└── README.md        # 项目说明文档
```

> 同一目录下的所有 `.tf` 文件在运行时会被 Terraform 自动合并加载，无需额外配置。

## 文件内容

### provider.tf

声明使用的 Provider 及其来源，并配置 region（认证通过环境变量注入，见下文）。

```hcl
terraform {
  required_providers {
    volcenginecc = {
      source = "volcengine/volcenginecc"
    }
  }
}

provider "volcenginecc" {
  region = var.region
}
```

### variables.tf

声明所有可配置的输入变量，均带默认值。

```hcl
variable "region" {
  description = "Volcengine region"
  type        = string
  default     = "cn-beijing"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "vpc-demo"
}

variable "vpc_description" {
  description = "Description of the VPC"
  type        = string
  default     = "VPC created by Terraform"
}

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "subnet-demo"
}

variable "subnet_description" {
  description = "Description of the subnet"
  type        = string
  default     = "Subnet created by Terraform"
}

variable "subnet_cidr_block" {
  description = "CIDR block of the subnet"
  type        = string
  default     = "192.168.1.0/24"
}

variable "subnet_zone_id" {
  description = "Availability zone ID of the subnet"
  type        = string
  default     = "cn-beijing-a"
}

variable "tags" {
  description = "Tags applied to the VPC and subnet"
  type = list(object({
    key   = string
    value = string
  }))
  default = [
    {
      key   = "env"
      value = "prod"
    }
  ]
}
```

### main.tf

核心资源定义：先创建 VPC，Subnet 通过引用 `volcenginecc_vpc_vpc.vpc-demo.id` 关联到该 VPC。

```hcl
resource "volcenginecc_vpc_vpc" "vpc-demo" {
  vpc_name    = var.vpc_name
  description = var.vpc_description
  cidr_block  = var.vpc_cidr_block

  tags = var.tags
}

resource "volcenginecc_vpc_subnet" "subnet-demo" {
  vpc_id      = volcenginecc_vpc_vpc.vpc-demo.id
  zone_id     = var.subnet_zone_id
  subnet_name = var.subnet_name
  description = var.subnet_description
  cidr_block  = var.subnet_cidr_block

  tags = var.tags
}
```

### outputs.tf

声明 apply 后导出的资源属性。

```hcl
output "vpc_id" {
  description = "ID of the created VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.id
}

output "vpc_name" {
  description = "Name of the created VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.vpc_name
}

output "vpc_cidr_block" {
  description = "CIDR block of the created VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.cidr_block
}

output "vpc_description" {
  description = "Description of the created VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.description
}

output "vpc_status" {
  description = "Status of the created VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.status
}

output "vpc_creation_time" {
  description = "Creation time of the VPC"
  value       = volcenginecc_vpc_vpc.vpc-demo.creation_time
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.id
}

output "subnet_name" {
  description = "Name of the created subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.subnet_name
}

output "subnet_cidr_block" {
  description = "CIDR block of the created subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.cidr_block
}

output "subnet_description" {
  description = "Description of the created subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.description
}

output "subnet_zone_id" {
  description = "Availability zone ID of the subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.zone_id
}

output "subnet_status" {
  description = "Status of the subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.status
}

output "subnet_available_ip_count" {
  description = "Number of available IP addresses in the subnet"
  value       = volcenginecc_vpc_subnet.subnet-demo.available_ip_address_count
}
```

### .gitignore

忽略 Terraform state、lock、密钥变量等不应提交的文件。

```gitignore
# Terraform
.terraform/
.terraform.lock.hcl
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
crash.log
crash.*.log
override.tf
override.tf.json
*_override.tf
*_override.tf.json
.terraformrc
terraform.rc

# OS
.DS_Store
```

## 输入变量说明

| 变量名 | 说明 | 类型 | 默认值 |
|--------|------|------|--------|
| `region` | 火山引擎地域 | `string` | `cn-beijing` |
| `vpc_name` | VPC 名称 | `string` | `vpc-demo` |
| `vpc_description` | VPC 描述 | `string` | `VPC created by Terraform` |
| `vpc_cidr_block` | VPC 网段 | `string` | `192.168.0.0/16` |
| `subnet_name` | 子网名称 | `string` | `subnet-demo` |
| `subnet_description` | 子网描述 | `string` | `Subnet created by Terraform` |
| `subnet_cidr_block` | 子网网段 | `string` | `192.168.1.0/24` |
| `subnet_zone_id` | 子网可用区 | `string` | `cn-beijing-a` |
| `tags` | VPC 与子网的标签 | `list(object)` | `[{ key = "env", value = "prod" }]` |

> 注意：`subnet_zone_id` 必须属于 `region` 所在地域，否则子网创建会失败。

## 输出变量说明

| 输出名 | 说明 |
|--------|------|
| `vpc_id` | VPC ID |
| `vpc_name` | VPC 名称 |
| `vpc_cidr_block` | VPC 网段 |
| `vpc_description` | VPC 描述 |
| `vpc_status` | VPC 状态 |
| `vpc_creation_time` | VPC 创建时间 |
| `subnet_id` | 子网 ID |
| `subnet_name` | 子网名称 |
| `subnet_cidr_block` | 子网网段 |
| `subnet_description` | 子网描述 |
| `subnet_zone_id` | 子网可用区 |
| `subnet_status` | 子网状态 |
| `subnet_available_ip_count` | 子网可用 IP 数量 |

## 使用方法

### 1. 前置条件

- 已安装 [Terraform](https://developer.hashicorp.com/terraform/install)（建议 v1.x）
- 拥有火山引擎账号的 AccessKey / SecretKey

### 2. 配置认证

通过环境变量注入密钥（推荐，避免写入代码）：

```bash
export VOLCENGINE_ACCESS_KEY="你的 AccessKey"
export VOLCENGINE_SECRET_KEY="你的 SecretKey"
```

### 3. 初始化、预览与创建

```bash
terraform init      # 初始化，下载 Provider
terraform plan      # 预览将要创建的资源
terraform apply     # 创建资源（确认后输入 yes）
```

如需覆盖默认变量，可使用 `-var` 参数：

```bash
terraform apply -var="vpc_cidr_block=10.0.0.0/16" -var="region=cn-shanghai" -var="subnet_zone_id=cn-shanghai-a"
```

### 4. 查看输出

```bash
terraform output            # 查看全部输出
terraform output vpc_id     # 查看单个输出
```

### 5. 销毁资源

> 警告：该操作会删除已创建的 VPC 与 Subnet，不可恢复。

```bash
terraform destroy
```
