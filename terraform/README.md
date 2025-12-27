# Terraform – LocalStack Learning Setup

This repository contains Terraform configurations for provisioning AWS resources (Lambda, S3, IAM, CloudWatch, etc.) using **LocalStack**.
The setup supports **multiple environments** using Terraform workspaces and environment-specific backend and variable files.

----

## 🚀 How to Deploy

### Move to the Terraform folder

```bash
cd terraform
```

---

### Set the AWS PROFILE and environment

set the AWS Profile which you're using

```bash
export AWS_PROFILE=localstack
```

Set the environment you want to work with (`development`, `staging`, `production`).

```bash
export TF_ENV=development
```

---

### Initialize Terraform

Initialize Terraform using the backend configuration for the selected environment.

```bash
terraform init -backend-config=./backend/${TF_ENV}.conf
```

---

### Select or create workspace

```bash
terraform workspace select -or-create ${TF_ENV}
```

---

### Review planned changes

```bash
terraform plan -var-file=./workspace/${TF_ENV}.tfvars
```

---

### Apply the deployment

```bash
terraform apply -var-file=./workspace/${TF_ENV}.tfvars
```

---

### View outputs

Retrieve output values (useful for Lambda ARNs, bucket names, etc.).

```bash
terraform output
```

---

## 🧹 Cleanup (Optional)

To destroy resources in the selected environment:

```bash
terraform destroy -var-file=./workspace/${TF_ENV}.tfvars
```

---
