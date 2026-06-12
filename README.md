# Terraform for DevOps terraform.tf          # Provider config & version constraints
ec2.tf                # EC2 instance, security group, key pair
dynamodb.tf           # DynamoDB table
script.sh             # EC2 user_data bootstrap script

        
                                              
for_each.tf       # for_each & dynamic blocks
    lifecycle.tf      # lifecycle meta-argument
    import.tf         # import blocks (Terraform 1.5+)
    removed.tf        # removed blocks (safe removal)
    Complete Guide

### 1. Setup & Initialization

**Install Terraform (Linux/Ubuntu)**
```sh
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Verify installation
terraform -v
```

**Install Terraform (macOS)**
```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

**Initialize Terraform**
```sh
terraform init
```
- Downloads provider plugins
- Sets up the working directory

### 2. Core Commands
```sh
terraform fmt           # Format code to standard style
terraform validate      # Validate syntax and configuration
terraform plan          # Preview changes without applying
terraform apply         # Create/update infrastructure
terraform apply -auto-approve  # Apply without confirmation
terraform destroy       # Destroy all managed resources
terraform destroy -auto-approve  # Destroy without confirmation
```

### 3. Managing State
```sh
terraform state list              # List all managed resources
terraform show                    # Show detailed resource info
terraform state mv <src> <dest>   # Move resource in state
terraform state rm <resource>     # Remove from state (not from cloud)
```

**Remote Backend (S3 + DynamoDB for locking)**
```hcl
terraform {
 backend "s3" {
   bucket         = "my-terraform-state"
   key            = "global/s3/terraform.tfstate"
   region         = "us-east-1"
   dynamodb_table = "terraform-lock"
   encrypt        = true
 }
}
```

### 4. Variables & Outputs
```sh
terraform apply -var="instance_type=t3.small"  # Pass variable via CLI
terraform output                                # Show all outputs
terraform output ec2_public_ip                  # Show specific output
```

### 5. Workspaces
```sh
terraform workspace new dev       # Create workspace
terraform workspace select prod   # Switch workspace
terraform workspace list          # List all workspaces
```

### 6. Testing (Terraform 1.6+)
```sh
terraform test                    # Run all .tftest.hcl files
```

### 7. Debugging
```sh
export TF_LOG=DEBUG               # Enable debug logs
terraform apply 2>&1 | tee debug.log
```

---
