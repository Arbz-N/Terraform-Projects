 AWS Infrastructure Deployment using Terraform

## Project Overview

This project demonstrates how to use **Terraform** to provision a complete and highly available **AWS web infrastructure**.  
The infrastructure includes networking components, compute resources, security configuration, and an application load balancer to distribute traffic across multiple EC2 instances.

The goal of this project is to practice **Infrastructure as Code (IaC)** concepts and understand how real-world AWS architectures are built and automated using Terraform.

---

## Prerequisites

Before deploying this project, ensure you have the following:

- An active **AWS account**
- **Terraform** installed (version 1.x or later)
- **AWS CLI** installed and configured
- IAM user or role with permissions for:
  - EC2
  - VPC
  - ELB (Application Load Balancer)
  - S3
- An existing **SSH key pair public key file**

---

## Project Structure

.
- main.tf # Core infrastructure resources
- provider.tf # AWS provider configuration
- variables.tf # Input variable definitions
- terraform.tfvars # Variable values (customizable)
- outputs.tf # Output values
- userdata1.sh # User data for Web Server 1
- userdata2.sh # User data for Web Server 2
- README.md

yaml
Copy code

---

## Infrastructure Components Explanation

### 1. Networking (VPC & Subnets)

- A custom **VPC** is created using a configurable CIDR block (`<VPC_CIDR>`).
- Two **public subnets** are provisioned in different availability zones to ensure high availability.
- An **Internet Gateway** is attached to the VPC to allow internet access.
- A **Route Table** routes outbound traffic (`0.0.0.0/0`) through the Internet Gateway.
- Both subnets are associated with the route table.

---

### 2. Security Group Configuration

- A security group is created inside the VPC.
- **Ingress rules** allow:
  - SSH access (port 22)
  - HTTP access (port 80)
- **Egress rules** allow all outbound traffic.

> Note: SSH access is open for learning purposes only and should be restricted in production environments.

---

### 3. EC2 Instances (Web Servers)

- Two EC2 instances are launched in separate subnets.
- Instance details such as AMI ID and instance type are provided via variables:
  - `<AMI_ID>`
  - `<INSTANCE_TYPE>`
- User data scripts automatically:
  - Install Apache web server
  - Retrieve the EC2 Instance ID using the metadata service (IMDSv2)
  - Generate a custom `index.html` file
  - Start and enable Apache on boot

Each instance displays its own identity, making it easy to verify load balancing.

---

### 4. Application Load Balancer (ALB)

- An **Application Load Balancer** is created to distribute incoming HTTP traffic.
- The ALB listens on port **80**.
- A **target group** forwards traffic to both EC2 instances.
- Health checks ensure only healthy instances receive traffic.

This provides fault tolerance and load distribution.

---

### 5. S3 Bucket

- An S3 bucket is created for demonstration purposes.
- The bucket name is defined using a placeholder:
  - `<S3_BUCKET_NAME>`
- This resource can be extended for static assets or logging use cases.

---

### 6. Output Values

- After deployment, Terraform outputs the **DNS name of the Application Load Balancer**.
- This DNS name can be accessed in a browser to view the running application.

Example:
http://<ALB_DNS_NAME>

yaml
Copy code

---

## Deployment Instructions

### Step 1: Initialize Terraform
```bash
terraform init
Step 2: Validate Configuration
bash
Copy code
terraform validate
Step 3: Review Execution Plan
bash
Copy code
terraform plan
Step 4: Apply Infrastructure
bash
Copy code
terraform apply
Cleanup
To remove all resources created by Terraform:

bash
Copy code
terraform destroy
Key Learning Outcomes
Infrastructure as Code using Terraform

AWS VPC and networking fundamentals

Load balancing with Application Load Balancer

EC2 automation using user data

High availability architecture design