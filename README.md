# ⚡ AWS Static Website — S3 + CloudFront + GitHub Actions

<p align="center">
  <strong>Production-ready static website deployment on AWS</strong><br>
  <sub>Terraform • Amazon S3 • CloudFront • GitHub Actions • OIDC</sub>
</p>

<p align="center">

![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge\&logo=amazon-aws)
![S3](https://img.shields.io/badge/Amazon%20S3-Storage-569A31?style=for-the-badge\&logo=amazons3\&logoColor=white)
![CloudFront](https://img.shields.io/badge/CloudFront-CDN-8C4FFF?style=for-the-badge\&logo=amazon-aws\&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?style=for-the-badge\&logo=terraform\&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-2088FF?style=for-the-badge\&logo=github-actions\&logoColor=white)

</p>

---

## 🚀 Project Overview

A modern, responsive static website deployed on **Amazon S3** and distributed globally through **Amazon CloudFront**.

Infrastructure is provisioned using **Terraform**, while website updates are automatically deployed through **GitHub Actions**.

> **Push code → GitHub Actions → S3 → CloudFront → Live Website**

---

## 🏗️ Architecture

```text
                         ┌─────────────────────┐
                         │     Developer       │
                         │                     │
                         │ HTML / CSS / JS     │
                         └──────────┬──────────┘
                                    │
                                    │ git push
                                    ▼
                         ┌─────────────────────┐
                         │       GitHub        │
                         │     Repository      │
                         └──────────┬──────────┘
                                    │
                                    ▼
                         ┌─────────────────────┐
                         │   GitHub Actions    │
                         │                     │
                         │  ✓ Validate         │
                         │  ✓ Authenticate     │
                         │  ✓ Deploy           │
                         │  ✓ Invalidate CDN   │
                         └──────────┬──────────┘
                                    │
                         OIDC / IAM Role
                                    │
                                    ▼
                 ┌─────────────────────────────────┐
                 │             AWS                  │
                 │                                 │
                 │   ┌─────────────────────────┐   │
                 │   │          S3             │   │
                 │   │     Private Bucket      │   │
                 │   └────────────┬────────────┘   │
                 │                │                │
                 │                │ OAC            │
                 │                ▼                │
                 │   ┌─────────────────────────┐   │
                 │   │       CloudFront        │   │
                 │   │       Global CDN        │   │
                 │   └────────────┬────────────┘   │
                 └────────────────┼────────────────┘
                                  │
                                  │ HTTPS
                                  ▼
                         ┌─────────────────────┐
                         │       Users         │
                         │     Worldwide       │
                         └─────────────────────┘
```

---

## ✨ Features

| Feature                 | Implementation          |
| ----------------------- | ----------------------- |
| 🌐 Static hosting       | Amazon S3               |
| 🚀 Global CDN           | Amazon CloudFront       |
| 🔐 S3 security          | Private bucket + OAC    |
| 🏗️ Infrastructure      | Terraform               |
| 🔄 CI/CD                | GitHub Actions          |
| 🔑 AWS authentication   | GitHub OIDC             |
| 🔒 HTTPS                | CloudFront              |
| ⚡ Caching               | CloudFront              |
| 📱 Responsive UI        | HTML + CSS              |
| 🧹 Automated deployment | `aws s3 sync`           |
| ♻️ Cache refresh        | CloudFront invalidation |

---

## 📁 Project Structure

```text
.
├── .github/
│   └── workflows/
│       └── deploy.yml
│
├── assets/
│   ├── style.css
│   └── script.js
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── index.html
├── README.md
└── .gitignore
```

---

# 🛠️ Technology Stack

### Frontend

```text
HTML5
CSS3
JavaScript
Responsive Design
```

### AWS

```text
Amazon S3
Amazon CloudFront
AWS IAM
CloudFront Origin Access Control
```

### DevOps

```text
Terraform
Git
GitHub
GitHub Actions
AWS CLI
OIDC
```

---

# ☁️ AWS Infrastructure

## Amazon S3

The website files are stored in an S3 bucket.

The bucket is intentionally **not publicly accessible**.

```text
S3 Public Access
       ❌
       
CloudFront
       │
       │ OAC
       ▼
Private S3 Bucket
```

This prevents users from bypassing CloudFront and accessing the S3 bucket directly.

---

## CloudFront

CloudFront provides:

* Global content delivery
* HTTPS
* Edge caching
* Reduced latency
* Secure access to private S3
* Cache invalidation after deployment

Public traffic follows:

```text
User
 ↓
HTTPS
 ↓
CloudFront
 ↓
Origin Access Control
 ↓
Private S3
```

---

# 🏗️ Terraform Infrastructure

Initialize Terraform:

```bash
cd terraform

terraform init
```

Review the infrastructure:

```bash
terraform plan
```

Create the AWS resources:

```bash
terraform apply
```

Get the outputs:

```bash
terraform output
```

Example:

```text
bucket_name                 = "shankar-devops-portfolio-a1b2c3d4"

cloudfront_distribution_id = "E123ABC456XYZ"

cloudfront_url              = "https://d123abc456xyz.cloudfront.net"
```

---

# 🔄 CI/CD Pipeline

Every change merged into `main` automatically triggers the deployment pipeline.

```text
Developer
    │
    ▼
Feature Branch
    │
    ▼
Pull Request
    │
    ▼
Code Review
    │
    ▼
main
    │
    ▼
GitHub Actions
    │
    ├── Checkout
    │
    ├── Validate
    │
    ├── Authenticate using OIDC
    │
    ├── Sync files to S3
    │
    ├── Invalidate CloudFront
    │
    └── Deployment Complete
    │
    ▼
Production Website
```

---

# ⚙️ GitHub Actions

Workflow:

```text
.github/workflows/deploy.yml
```

The pipeline performs:

### 1️⃣ Checkout

```yaml
- uses: actions/checkout@v4
```

### 2️⃣ Validate

```bash
test -f index.html
test -f assets/style.css
test -f assets/script.js
```

### 3️⃣ AWS Authentication

GitHub Actions authenticates using:

```text
GitHub OIDC
      ↓
AWS IAM Role
      ↓
Temporary AWS Credentials
```

No permanent AWS access keys are required.

### 4️⃣ Deploy to S3

```bash
aws s3 sync . s3://YOUR_BUCKET_NAME
```

### 5️⃣ Invalidate CloudFront

```bash
aws cloudfront create-invalidation \
  --distribution-id YOUR_DISTRIBUTION_ID \
  --paths "/*"
```

---

# 🔐 GitHub Secrets

Configure the following repository secrets:

```text
Settings
   ↓
Secrets and variables
   ↓
Actions
```

Add:

| Secret                       | Description                |
| ---------------------------- | -------------------------- |
| `AWS_DEPLOY_ROLE_ARN`        | IAM role assumed by GitHub |
| `S3_BUCKET`                  | Static website S3 bucket   |
| `CLOUDFRONT_DISTRIBUTION_ID` | CloudFront distribution ID |

Example:

```text
AWS_DEPLOY_ROLE_ARN
arn:aws:iam::123456789012:role/github-actions-static-site
```

```text
S3_BUCKET
shankar-devops-portfolio-a1b2c3d4
```

```text
CLOUDFRONT_DISTRIBUTION_ID
E123ABC456XYZ
```

---

# 🌿 Git Workflow

Create a feature branch:

```bash
git checkout -b feature/new-section
```

Make your changes.

```bash
git add .
```

Commit:

```bash
git commit -m "Add new projects section"
```

Push:

```bash
git push origin feature/new-section
```

Create a Pull Request:

```text
feature/new-section
        │
        ▼
   Pull Request
        │
        ▼
   Code Review
        │
        ▼
     Merge
        │
        ▼
      main
        │
        ▼
 GitHub Actions
        │
        ▼
   AWS Deployment
```

---

# 🌍 Access the Website

After deployment:

```bash
terraform output cloudfront_url
```

Example:

```text
https://d123abc456xyz.cloudfront.net
```

Open the URL in your browser.

---

# ♻️ Manual CloudFront Invalidation

If required:

```bash
aws cloudfront create-invalidation \
  --distribution-id YOUR_DISTRIBUTION_ID \
  --paths "/*"
```

Or directly through Terraform:

```bash
aws cloudfront create-invalidation \
  --distribution-id $(terraform output -raw cloudfront_distribution_id) \
  --paths "/*"
```

---

# 🧪 Local Development

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
```

Enter the project:

```bash
cd YOUR_REPOSITORY
```

You can run the website locally using VS Code Live Server or a simple HTTP server:

```bash
python -m http.server 8080
```

Open:

```text
http://localhost:8080
```

---

# 📊 Deployment Flow

```text
┌──────────────────────────────┐
│        Developer             │
└──────────────┬───────────────┘
               │
               │ git push
               ▼
┌──────────────────────────────┐
│          GitHub              │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│      GitHub Actions          │
│                              │
│  ✓ Checkout                  │
│  ✓ Validate                  │
│  ✓ AWS OIDC Authentication   │
│  ✓ S3 Deployment             │
│  ✓ CloudFront Invalidation   │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│        Amazon S3             │
│      Private Website         │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│        CloudFront            │
│        Global CDN            │
└──────────────┬───────────────┘
               │
               ▼
        🌍 LIVE WEBSITE
```

---

# 🔒 Security Design

This project follows a security-first deployment model.

### S3

```text
Public Access: BLOCKED
```

### CloudFront

```text
HTTPS: ENABLED
OAC: ENABLED
```

### GitHub

```text
Long-lived AWS keys: ❌
OIDC authentication: ✅
Temporary credentials: ✅
```

### IAM

Use least-privilege permissions for:

```text
S3
CloudFront
```

---

# 📈 Future Improvements

The project can be extended with:

* [ ] Custom domain using Route 53
* [ ] AWS Certificate Manager SSL certificate
* [ ] Staging environment
* [ ] Production environment
* [ ] Pull Request validation
* [ ] HTML/CSS linting
* [ ] Automated security scanning
* [ ] Terraform remote state
* [ ] S3 versioning
* [ ] CloudWatch monitoring
* [ ] AWS WAF
* [ ] Blue/Green deployment strategy
* [ ] Approval before production deployment
* [ ] Automated rollback

---

# 💡 DevOps Concepts Demonstrated

This project demonstrates practical knowledge of:

```text
Infrastructure as Code
        ↓
Terraform
        ↓
Cloud Infrastructure
        ↓
AWS S3 + CloudFront
        ↓
Secure Authentication
        ↓
GitHub OIDC + IAM
        ↓
Continuous Integration
        ↓
GitHub Actions
        ↓
Continuous Deployment
        ↓
Automated Production Release
```

---

# 🎯 Resume / Portfolio Value

### Project Title

**Automated AWS Static Website Deployment using Terraform & GitHub Actions**

### Key Technologies

```text
AWS | S3 | CloudFront | Terraform |
GitHub Actions | IAM | OIDC | Git | HTML | CSS | JavaScript
```

### Achievement Highlights

* Automated static website deployment to Amazon S3 using GitHub Actions.
* Implemented CloudFront CDN with HTTPS for global content delivery.
* Secured S3 using private bucket access and CloudFront Origin Access Control.
* Provisioned AWS infrastructure using reusable Terraform configuration.
* Implemented GitHub OIDC authentication to eliminate long-lived AWS credentials.
* Automated CloudFront cache invalidation after every production deployment.
* Implemented a Git-based feature branch and pull-request workflow.

---

# 👨‍💻 Author

**Shankar Narayan Sahu**

AWS | DevOps | Cloud | CI/CD | Terraform | Kubernetes

<p align="center">

⭐ If you found this project useful, consider giving it a star!

</p>
