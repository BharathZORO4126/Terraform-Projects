# Setup Terraform for AWS

This guide explains how to configure AWS credentials and set up Terraform to work with AWS.

## Prerequisites

* AWS Account
* Terraform installed on your system
* AWS CLI installed on your system

---

## Step 1: Install AWS CLI

Install the AWS Command Line Interface (CLI) on your machine.

### Verify Installation

```bash
aws --version
```

Expected output:

```bash
aws-cli/2.x.x Python/3.x.x
```

---

## Step 2: Create an IAM User

To allow Terraform to interact with AWS services securely, create a dedicated IAM user.

### Create IAM User

1. Sign in to the AWS Management Console.
2. Navigate to **IAM (Identity and Access Management)**.
3. Click **Users** → **Create User**.
4. Enter a username (e.g., `terraform-user`).
5. Click **Next**.

### Assign Permissions

Attach the required policies based on your use case.

For learning and testing purposes, you can attach:

* `AmazonEC2FullAccess`

For production environments, follow the principle of least privilege and grant only the permissions required.

### Create Access Keys

1. Open the newly created IAM user.
2. Navigate to **Security Credentials**.
3. Click **Create Access Key**.
4. Select **Command Line Interface (CLI)**.
5. Save the following credentials securely:

```text
Access Key ID
Secret Access Key
```

> **Important:** The Secret Access Key is displayed only once.

---

## Step 3: Configure AWS CLI

Run the following command:

```bash
aws configure
```

Provide the requested information:

```text
AWS Access Key ID: <YOUR_ACCESS_KEY>
AWS Secret Access Key: <YOUR_SECRET_KEY>
Default region name: us-east-1
Default output format: json
```

### Example

```bash
aws configure
```

```text
AWS Access Key ID [None]: AKIAxxxxxxxxxxxx
AWS Secret Access Key [None]: xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Default region name [None]: us-east-1
Default output format [None]: json
```

---

## Step 4: Verify AWS Configuration

Run:

```bash
aws sts get-caller-identity
```

Expected output:

```json
{
  "UserId": "XXXXXXXXXXXX",
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:user/terraform-user"
}
```

---

## Step 5: Install Terraform

### Verify Installation

```bash
terraform version
```

Expected output:

```bash
Terraform v1.x.x
```

---

## Step 6: Create a Terraform Configuration

Create a file named `main.tf`.

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-091138d0f0d41ff90"
  instance_type = "t2.micro"
}
```

---

## Step 7: Initialize Terraform

```bash
terraform init
```

This command downloads the required AWS provider plugins.

---

## Step 8: Validate Configuration

```bash
terraform validate
```

Expected output:

```text
Success! The configuration is valid.
```

---

## Step 9: Review Execution Plan

```bash
terraform plan
```

Terraform displays the resources that will be created.

---

## Step 10: Apply Configuration

```bash
terraform apply
```

Type:

```text
yes
```

when prompted.

Terraform will create the AWS resources defined in your configuration.

---

## Step 11: Destroy Resources (Optional)

To avoid AWS charges, remove resources when no longer needed.

```bash
terraform destroy
```

Type:

```text
yes
```

to confirm.

---

## Useful Commands

```bash
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
terraform destroy
terraform state list
```

---

## Best Practices

* Never hardcode AWS credentials in Terraform files.
* Use IAM roles whenever possible.
* Store Terraform state remotely (e.g., S3 + DynamoDB).
* Follow the principle of least privilege for IAM permissions.
* Use version control (Git) for Terraform code.

---

## References

* Terraform Documentation: https://developer.hashicorp.com/terraform/docs
* AWS CLI Documentation: https://docs.aws.amazon.com/cli/
* AWS IAM Documentation: https://docs.aws.amazon.com/IAM/

