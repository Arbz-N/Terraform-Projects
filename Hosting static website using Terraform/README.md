# Terraform Project: S3 Static Website Hosting

This project demonstrates how to deploy a **static website** on **AWS S3** using **Terraform**.  
It automates the creation of a public S3 bucket, applies the appropriate bucket policy, 
configures it for static website hosting, and uploads the website files.

---

## Table of Contents

- [Project Overview](#project-overview)  
- [Architecture](#architecture)  
- [Prerequisites](#prerequisites)  
- [Project Structure](#project-structure)  
- [Setup Instructions](#setup-instructions)  
- [Terraform Commands](#terraform-commands)  
- [Outputs](#outputs)  
- [Notes](#notes)  

---

## Project Overview

The Terraform configuration in this project performs the following tasks:

1. Generates a **unique bucket name** using `random_id`.  
2. Creates an **S3 bucket** configured for **static website hosting**.  
3. Configures **public access policies** to allow read access to objects.  
4. Uploads website files (`index.html`, `styles.css`) to the bucket.  
5. Outputs the **website endpoint** for easy access.

---



---

## Prerequisites

Before running this project, ensure you have:

- Terraform installed (v1.x or higher)  
- AWS CLI configured with credentials  
- `index.html` and `styles.css` prepared for your website  
- Permissions to create S3 buckets and modify bucket policies  

---

## Project Structure

.
- main.tf # Main Terraform resources
- variables.tf # Input variables
- outputs.tf # Output variables
- terraform.tfvars # User-defined variable values
- index.html # Static website HTML file
- styles.css # CSS file for styling
- README.md # Project documentation


---

## Setup Instructions

1. Clone the repository:

```bash
git clone <repository-url>
cd <repository-folder>
Update terraform.tfvars with your environment-specific values:

hcl
Copy code
AWS_REGION       = "<YOUR_AWS_REGION>"
RANDOM_ID_LENGTH = 4
LOCAL_INDEX_HTML = "./index.html"
LOCAL_CSS_FILE   = "./styles.css"
Initialize Terraform:

terraform init
Review the execution plan:

terraform plan
Apply the Terraform configuration:

terraform apply
Confirm by typing yes when prompted.

Terraform Commands
Initialize Terraform:

terraform init
Check plan before applying:

terraform plan
Deploy infrastructure:

terraform apply
Destroy infrastructure:

terraform destroy
Outputs
After deployment, Terraform will output:

website_static_link – The URL of your hosted static website.

Example:

http://s3-static-website-abc123.s3-website-us-east-1.amazonaws.com

Notes

The bucket name is dynamically generated using random_id to avoid collisions.
Public read access is configured using S3 bucket policy.
Sensitive information such as AWS credentials are not stored in the repository.
Placeholders in terraform.tfvars allow you to safely share this project on GitHub.