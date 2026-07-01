# Server Scripts

Ansible playbooks, roles, and Terraform configuration to manage server infrastructure.

## Project Structure

```text
├── .github/          # GitHub Workflows and Dependabot config
├── ansible/          # Ansible configuration, playbooks, and roles
│   ├── playbooks/    # Server setup and application playbooks
│   └── roles/        # Shared Ansible roles
├── terraform/        # Cloudflare and OpenTofu IaC configs
├── pyproject.toml    # Python project dependencies (PEP 621)
├── uv.lock           # Dependency lockfile managed by uv
└── Makefile          # Environment and execution manager
```

## Prerequisites

Ensure the following tools are installed on your control node:
- **uv** (Python packaging)
- **Infisical CLI** (Secret management)
- **OpenTofu** (IaC)
- **pre-commit** (Pre-commit hooks)
- **Docker** (Required for containerized pre-commit hooks like TFLint and TruffleHog)
- **sshpass** (For Ansible SSH password auth)

## Quick Start

1. Initialize the environment (configures pre-commit, Infisical, and installs Python/Ansible dependencies):
   ```bash
   make init
   ```

2. Run playbooks using `make`:
   ```bash
   # System update
   make ansible-system-update

   # Install Docker
   make ansible-system-install-docker
   ```

Refer to the `Makefile` for a complete list of targets.
