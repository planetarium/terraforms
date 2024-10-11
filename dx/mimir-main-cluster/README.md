## Prerequisites

- Terraform installed on your local machine.
- Access to our 1Password vault that contains the necessary secrets.
- The `op` command-line tool installed for 1Password secret injection.

## Setup Instructions

### 1. Prepare Your Terraform Configuration

Ensure your Terraform configuration files are set up correctly. For managing secrets, we use a template file named `terraform.tfvars.tpl`, which contains placeholders for secrets that will be injected from 1Password.

Example of `terraform.tfvars.tpl` content:

```hcl
...
existing_subnet_ids_public = "op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_public"
...
```

### 2. Inject Secrets with 1Password

Before running any Terraform commands, you need to inject secrets into your configuration. This is done using the `op` command-line tool and the provided script.
The script replaces placeholders in `terraform-private.tfvars.tpl` with actual secrets from 1Password and outputs the result to `terraform-private.tfvars`.

Run the following command in your terminal:

```bash
op inject -i terraform-private.tfvars.tpl -o terraform-private.tfvars
```

This command reads the template file `terraform.tfvars.tpl`, injects secrets from 1Password, and writes the output to `terraform.tfvars`.

### 3. Proceed with Terraform Commands

After injecting the secrets, you can proceed with Terraform commands. For example, to plan your infrastructure changes, you can run:

```bash
terraform plan -var-file=<(cat terraform-public.tfvars terraform-private.tfvars)
```

For convenience, you can combine the secrets injection and Terraform planning into one command:

```bash
op inject -i terraform-private.tfvars.tpl -o terraform-private.tfvars && terraform plan -var-file=<(cat terraform-public.tfvars terraform-private.tfvars)
```
