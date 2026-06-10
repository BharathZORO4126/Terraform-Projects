provider "aws" {
    region = "us-east-1"  # Set your desired AWS region
}

resource "aws_instance" "example" {
    ami           = "ami-091138d0f0d41ff90"  # Specify an appropriate AMI ID
    instance_type = "t3.micro"
    subnet_id = "subnet-08474b95322035757"
    key_name  = "terraform_bharath"
}