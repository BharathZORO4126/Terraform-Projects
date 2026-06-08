# AWS EC2 Instance Creation using Terraform

## Overview

This Terraform configuration creates an AWS EC2 instance in the **us-east-1** region using a specified AMI, instance type, subnet, and SSH key pair.

## Terraform Configuration

```hcl
provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "example" {
    ami           = "ami-091138d0f0d41ff90"
    instance_type = "t3.micro"
    subnet_id     = "subnet-08474b95322035757"
    key_name      = "terraform_bharath"
}
```

---

## Code Explanation

### Provider Block

```hcl
provider "aws" {
    region = "us-east-1"
}
```

The provider block specifies the cloud provider that Terraform will interact with.

| Parameter | Description                                               |
| --------- | --------------------------------------------------------- |
| aws       | Indicates that AWS is the cloud provider.                 |
| region    | Specifies the AWS region where resources will be created. |

In this example:

```text
us-east-1
```

represents the **US East (N. Virginia)** AWS region.

---

### EC2 Instance Resource

```hcl
resource "aws_instance" "example" {
```

Defines an EC2 instance resource.

| Component    | Description                                   |
| ------------ | --------------------------------------------- |
| aws_instance | Terraform resource type for AWS EC2 instances |
| example      | Logical name used within Terraform            |

Terraform refers to this resource internally as:

```text
aws_instance.example
```

---

### AMI (Amazon Machine Image)

```hcl
ami = "ami-091138d0f0d41ff90"
```

The AMI specifies the operating system and software configuration for the EC2 instance.

Examples:

* Amazon Linux 2
* Amazon Linux 2023
* Ubuntu
* Red Hat Enterprise Linux
* Windows Server

To find available AMIs:

```bash
aws ec2 describe-images
```

or

AWS Console → EC2 → AMIs

---

### Instance Type

```hcl
instance_type = "t3.micro"
```

Defines the hardware configuration of the EC2 instance.

| Resource | Specification             |
| -------- | ------------------------- |
| vCPU     | 2                         |
| Memory   | 1 GB                      |
| Family   | Burstable General Purpose |

Common instance types:

| Type      | Usage                    |
| --------- | ------------------------ |
| t2.micro  | Free Tier eligible       |
| t3.micro  | Small workloads          |
| t3.small  | Development environments |
| t3.medium | Medium applications      |

---

### Subnet ID

```hcl
subnet_id = "subnet-08474b95322035757"
```

Specifies the subnet in which the EC2 instance will be launched.

A subnet belongs to a VPC (Virtual Private Cloud).

Network Flow:

```text
AWS Account
   │
   └── VPC
        │
        └── Subnet
              │
              └── EC2 Instance
```

Benefits of using a subnet:

* Network isolation
* IP address allocation
* Route table control
* Security management

---

### Key Pair

```hcl
key_name = "terraform_bharath"
```

Associates an AWS Key Pair with the EC2 instance.

Purpose:

* Secure SSH access to Linux instances
* Authentication without passwords

Connect to the instance:

```bash
ssh -i terraform_bharath.pem ec2-user@<public-ip>
```

For Ubuntu:

```bash
ssh -i terraform_bharath.pem ubuntu@<public-ip>
```

---

## Terraform Workflow

### Initialize Terraform

```bash
terraform init
```

Downloads the AWS provider plugin.

---

### Validate Configuration

```bash
terraform validate
```

Checks the syntax of Terraform files.

---

### Review Execution Plan

```bash
terraform plan
```

Shows the resources Terraform intends to create.

---

### Create Resources

```bash
terraform apply
```

Type:

```text
yes
```

to confirm deployment.

---

### Verify Instance Creation

```bash
aws ec2 describe-instances
```

or

AWS Console → EC2 → Instances

---

### Destroy Resources

```bash
terraform destroy
```

Removes all resources created by Terraform.

---

## Architecture

```text
Terraform
    │
    ▼
AWS Provider
    │
    ▼
AWS EC2 Service
    │
    ▼
VPC
    │
    ▼
Subnet (subnet-08474b95322035757)
    │
    ▼
EC2 Instance (t3.micro)
    │
    ▼
SSH Access using Key Pair
(terraform_bharath.pem)
```

---

## Notes

* Ensure AWS credentials are configured before running Terraform.
* Verify that the subnet exists in the specified region.
* Ensure the key pair `terraform_bharath` exists in AWS.
* Security Groups should allow SSH (port 22) if remote access is required.
* The selected AMI must be available in the `us-east-1` region.

## Author

Terraform AWS EC2 Provisioning Example
