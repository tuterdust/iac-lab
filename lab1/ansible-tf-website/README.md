# Simple Frontend + Backend deployment using Ansible + Terraform

## Components

- **Backend**:  Python Flask App deployed as a container on a Compute Engine instance, configuration is defined in `./backend/`, Managed by Ansible + Terraform
- **Frontend**: Static page hosted in Google Cloud Storage bucket, configuration is defined in `./frontend.tf`, Managed by Terraform
- **Monitoring**: Google Cloud Dashboard, configuration is defined in `./dashboard.tf`, Managed by Terraform

## Guidelines

- Replace `{OWNER_NAME}` with your name or your identifier/alias (double quoted), check syntax carefully
- For backend, install Ansible role using `ansible-galaxy install -r requirements.yaml`
- Provision Compute Instance by running command

```ansible-playbook --limit 'backend_app_compute:localhost' provision.yaml```

- After the instance is created, replace ansible_host with the instance's external IP address (search and replace `{INSTANCE_IP}`)
- Run playbook config-instance.yaml to setup instance and run backend container using command

Run preview change

```ansible-playbook config-instance.yaml --diff --check```

Apply change
```ansible-playbook config-instance.yaml```

- At project root directory (same directory as this README), run `tofu plan` to validate the change and then `tofu apply` to provision frontend static page and monitoring dashboard

## Cleanup

- At root directory, Run `tofu destroy` to delete frontend and dashboard resources.
- At backend directory, run playbook to destroy Terraform resources

Run preview change

```ansible-playbook destroy-instance.yaml --diff --check```

Destroy resources
```ansible-playbook destroy-instance.yaml```
