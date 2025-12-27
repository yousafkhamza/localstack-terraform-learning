# LocalStack Setup (Docker + AWS CLI)

This repository is used to learn and test AWS services **locally** using **LocalStack**, without connecting to real AWS.

---

## Prerequisites

* Docker
* AWS CLI
* Linux / WSL / macOS

---

## 1. Start LocalStack

Run LocalStack using Docker:

```bash
docker run \
  --rm -it \
  -p 127.0.0.1:4566:4566 \
  -p 127.0.0.1:4510-4559:4510-4559 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  localstack/localstack
```

* Keep this terminal running
* Open a **new terminal** for AWS CLI commands

---

## 2. Configure AWS CLI for LocalStack

### Create a LocalStack AWS profile

```bash
aws configure --profile localstack
```

Use **dummy credentials**:

* Access Key ID: `test`
* Secret Access Key: `test`
* Region: `us-east-1`
* Output format: `json`

---

### Configure endpoint

Edit `~/.aws/config`:

```ini
[profile localstack]
region = us-east-1
endpoint_url = http://localhost:4566
```

✅ No `.bashrc` exports required
✅ AWS CLI automatically routes requests to LocalStack

---

## 3. Verify LocalStack

### Create an S3 bucket

```bash
aws s3 mb s3://terraform-state-bucket --profile localstack
```

### List buckets

```bash
aws s3 ls --profile localstack
```

Expected output:

```text
terraform-state-bucket
```

---

## 4. Useful LocalStack Commands

```bash
aws s3 ls --profile localstack
aws ec2 describe-instances --profile localstack
aws ec2 describe-vpcs --profile localstack
aws ec2 describe-security-groups --profile localstack
aws ec2 describe-key-pairs --profile localstack
aws iam list-roles --profile localstack
aws lambda list-functions --profile localstack
```

---

## Notes

* All services run **locally**
* EC2 is **mocked** (no real VM)
* Safe for learning and experimentation
* No AWS costs involved

---

## Stop LocalStack

Press `Ctrl + C` in the Docker terminal.
