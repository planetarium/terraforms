# Prerequisites

- Terraform installed on your local machine.
  - If you are experiencing issues when using Terraform on Apple silicon (e.g. M1, M2, M3), please refer to [this article](https://discuss.hashicorp.com/t/template-v2-2-0-does-not-have-a-package-available-mac-m1/35099/4).
- Access to our 1Password vault that contains the necessary secrets.
- The `op` command-line tool installed for 1Password secret injection.

# Setup Instructions

## 1. Prepare Your Terraform Configuration

Ensure your Terraform configuration files are set up correctly. For managing secrets, we use a template file named `terraform.tfvars.tpl`, which contains placeholders for secrets that will be injected from 1Password.

Example of `terraform.tfvars.tpl` content:

```hcl
...
ninecub_image = "git-e942d33af36b7727cbf484f919b5dd0e4bef7cc2"
ninecubs_image = "git-02cfa4986ca3cd2c55a4f47523b0d233200254c8"
...
existing_subnet_ids_public = "op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_public"
...
```

## 2. Inject Secrets with 1Password

Before running any Terraform commands, you need to inject secrets into your configuration. This is done using the `op` command-line tool and the provided script.
The script replaces placeholders in `terraform.tfvars.tpl` with actual secrets from 1Password and outputs the result to `terraform.tfvars`.

Run the following command in your terminal:

```bash
op inject -i terraform.tfvars.tpl -o terraform.tfvars
```

This command reads the template file `terraform.tfvars.tpl`, injects secrets from 1Password, and writes the output to `terraform.tfvars`.

## 3. Proceed with Terraform Commands

After injecting the secrets, you can proceed with Terraform commands. For example, to plan your infrastructure changes, you can run:

```bash
terraform plan
```

For convenience, you can combine the secrets injection and Terraform planning into one command:

```bash
op inject -i terraform.tfvars.tpl -o terraform.tfvars && terraform plan
```

https://discuss.hashicorp.com/t/template-v2-2-0-does-not-have-a-package-available-mac-m1/35099/4
