# Terraform + AWS + Ansible

## Project Overview

This project demonstrates Infrastructure as Code (IaC) using Terraform and configuration management using Ansible.

Terraform is used to provision an Ubuntu EC2 instance on AWS, configure SSH access, and create the required security group.

Ansible is then used to configure the newly created server by installing and enabling NGINX and deploying a static website.

**Roadmap.sh Project Reference:**

https://roadmap.sh/projects/iac-digitalocean

> This is an AWS implementation inspired by the roadmap.sh DigitalOcean IaC project.

## Technologies Used

- AWS EC2
- Terraform
- Ansible
- Ubuntu Linux
- NGINX
- SSH
- Git and GitHub
- HTML and CSS

## Project Architecture

1. Terraform provisions an Ubuntu EC2 instance on AWS.
2. Terraform creates an SSH key pair and an EC2 security group.
3. The EC2 instance receives a public IP address.
4. SSH is used to connect to the newly created server.
5. Ansible connects to the EC2 instance using the existing inventory file and SSH private key.
6. Ansible executes `setup.yml` to configure the server.
7. NGINX is installed and configured as a system service.
8. A static website is deployed to the NGINX web root.
9. The website is accessible through the EC2 instance's public IP address.

## Project Structure

```text
terraform-aws/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── setup.yml
├── inventory.ini.example
├── README.md
└── .gitignore
```

## Terraform Infrastructure

Terraform provisions the following AWS resources:

### EC2 Instance
- Ubuntu 24.04 server.
- Public IPv4 address.
- SSH key authentication.

### Security Group
- Port 22: SSH access restricted to the configured public IP.
- Port 80: HTTP traffic.
- Port 443: HTTPS traffic.

### Terraform Commands

Initialize Terraform:

```bash
terraform init
```

Format configuration files:

```bash
terraform fmt -recursive
```

Validate configuration:

```bash
terraform validate
```

Preview infrastructure changes:

```bash
terraform plan
```

Create AWS infrastructure:

```bash
terraform apply
```

Retrieve the EC2 public IP:

```bash
terraform output -raw public_ip
```

## Ansible Configuration

After Terraform creates the EC2 instance, Ansible is used to configure the server.

The existing Ansible inventory file is updated with the newly created EC2 public IP and SSH connection details.

Example inventory:

```ini
[web]
YOUR_EC2_PUBLIC_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_ed25519
```

### Ansible Playbook

The `setup.yml` playbook performs the following tasks:

- Updates the Ubuntu package cache.
- Installs NGINX.
- Starts the NGINX service.
- Enables NGINX to start automatically on boot.
- Deploys a static HTML website into `/var/www/html/`.

### Execute Ansible

Test connectivity:

```bash
ansible -i inventory.ini web -m ping
```

Check playbook syntax:

```bash
ansible-playbook -i inventory.ini setup.yml --syntax-check
```

Run the configuration playbook:

```bash
ansible-playbook -i inventory.ini setup.yml
```

## Static Website Deployment

Ansible deploys the static website to:

```text
/var/www/html/
```

NGINX serves the website over HTTP.

Open the following URL in a browser:

```text
http://YOUR_EC2_PUBLIC_IP
```

Replace the placeholder with the actual public IPv4 address of the EC2 instance.

## Infrastructure and Configuration Workflow

```text
Ubuntu Local Machine
        |
        v
    Terraform
        |
        v
   AWS Provider
        |
        v
    AWS EC2
        |
        v
  Public IP + SSH
        |
        v
   Ansible Inventory
        |
        v
   setup.yml Playbook
        |
        v
  Install and Configure NGINX
        |
        v
  Deploy Static Website
        |
        v
  Website Accessible via HTTP
```

## Security Practices

- AWS credentials are kept outside Terraform configuration files.
- Private SSH keys are never committed to GitHub.
- SSH access is restricted to a trusted public IP.
- Terraform state and local variable files are excluded from Git.
- Security group rules allow only the required network traffic.

## Cleanup

After completing the project, remove the Terraform-managed AWS resources:

```bash
terraform destroy
```

Review the proposed deletion and confirm with `yes`.

## Learning Outcomes

Through this project, I gained practical experience with:

- Infrastructure as Code using Terraform.
- Provisioning AWS EC2 instances.
- Configuring AWS security groups.
- SSH key-based server authentication.
- Managing infrastructure using Terraform lifecycle commands.
- Automating server configuration with Ansible.
- Installing and managing NGINX.
- Deploying a static website on an AWS server.
- Combining Terraform and Ansible in a basic DevOps workflow.

## References

- Roadmap.sh: https://roadmap.sh/projects/iac-digitalocean
- Terraform AWS Provider: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- Terraform Documentation: https://developer.hashicorp.com/terraform/docs
- Ansible Documentation: https://docs.ansible.com/
- AWS EC2 Documentation: https://docs.aws.amazon.com/ec2/

