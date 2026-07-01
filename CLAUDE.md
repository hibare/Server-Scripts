# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Infrastructure-as-code repository managing a Docker Swarm server fleet across OCI and on-premise nodes using Ansible for configuration management and OpenTofu for Cloudflare DNS/CDN.

## Key Commands

### Initialization
```bash
make init                                    # Install pre-commit hooks, uv sync, ansible-galaxy collections
```

### Running Ansible Playbooks
```bash
make ansible-system-update                   # Update all packages
make ansible-system-install-docker           # Install Docker with MTU configuration
make ansible-system-install-tailscale        # Install and configure Tailscale VPN
make ansible-system-setup-ufw               # Configure firewall
make ansible-system-docker-stack-update      # Update all Docker compose stacks
make ansible-system-install-grafana-alloy    # Install Grafana Alloy monitoring
make ansible-system-install-backup           # Install Arclift backup system
make ansible-system-configure-infisical-agent # Set up Infisical secrets agent
make ansible-system-new-user                 # Create a new system user (prompts for password)
```

Use `INVENTORY_FILE` to override inventory:
```bash
INVENTORY_FILE=test-inventory.ini make ansible-system-update
```

### Terraform / OpenTofu
```bash
make tf-cf-apply                             # Apply Cloudflare DNS/zone changes
```

### Code Quality
```bash
pre-commit run --all-files                   # Run all linters (black, ruff, terraform fmt, shellcheck, trufflehog)
```

### All playbooks are listed with descriptions in the Makefile:
```bash
make help                                    # Display all available targets
```

### Conventional Commits

This repo uses conventional commits. Common types: `feat:`, `fix:`, `chore:`, `refactor:`, `docs:`, `style:`.

Use `uv` (not pip or poetry) for Python dependency management:
```bash
uv sync                                      # Install dependencies
uv add <package>                             # Add a dependency
uv lock                                      # Update lockfile
```

## Architecture & Infrastructure

### Server Layout
- **Manager node:** `in-oci-01` (OCI, 152.67.3.242)
- **Agent nodes:** `in-oci-02` to `in-oci-05` (OCI), `in-onp-01`, `in-onp-02` (on-premise)
- **SSH user:** `shubham` with key-based auth
- **Networking:** Tailscale mesh VPN (100.64.0.0/10) with MTU 1280, Docker Swarm overlay networks (ingress, secure, db, dns, external)

### Configuration Management (Ansible)
- 29 playbooks in `ansible/playbooks/system/`, each with validation guards for required env vars
- One custom role: `json_modifier` — adds/removes keys in JSON files (used for `/etc/docker/daemon.json`)
- Playbooks sourced from `ansible/` directory (Makefile handles `cd`)
- Secrets injected via Infisical: `infisical run --env=prod --path=/server -- uv run ansible-playbook ...`
- Galaxy collections: community.docker, ansible.posix, grafana.grafana
- Standard pattern: validate env vars → install/configure → enable service

### DNS & CDN (Terraform/OpenTofu)
- `terraform/cloudflare/` manages two domains
- **hibare.in:** 30+ DNS records (A/AAAA, CNAME subdomains, MX for Zoho mail, DKIM/DMARC/SPF TXT records, SendGrid)
- **09876543.xyz:** Full zone settings + DDoS ruleset + firewall rules (blocks RU/CN/HK)

### Monitoring Stack
- Grafana Cloud (SaaS) with Grafana Alloy on each node
- Metrics: node_exporter + cadvisor → Prometheus remote write
- Logs: system logs (varlogs) + Docker logs (Loki plugin) → Loki remote write
- Alloy runs as root with systemd override

### Secrets Management
- Infisical agent polls every 60s, writes secrets to `/etc/infisical/env`, post-process script merges to `/etc/environment`
- Environment variables expected by playbooks are in `.env.example` (21 vars: Infisical, Grafana Cloud, S3, Discord webhooks, Terraform, etc.)

### Notifications
- Discord webhooks for: SSH login alerts, update notifications, reboot required

### Key Scripts
- `scripts/docker-stack-update/docker_stack_update.sh` — iterates `~/docker/*/docker-compose.yml`, pulls images, restarts services
- `scripts/env/merge_env.py` — merges env key-value pairs (used by Infisical post-process)
- `scripts/mega-cmd-monitor/` — systemd keeper for mega-cmd-server
- Profile.d scripts in `ansible/playbooks/system/config/` for SSH login alerts

## Security Notes

- **Hardcoded secrets exist in the repo** — `ansible/playbooks/system/config/` contains Backblaze B2 credentials, Discord webhooks, and K3s tokens. These should NOT be committed; handle with `git filter-repo` and rotate credentials.
- Infisical is the intended secrets backend — all sensitive configs should live there.
- Pre-commit includes TruffleHog for secret detection; verify its exclusions are correct.
- `.gitignore` excludes: `.env`, `config/`, `*inventory.ini`, `.tfstate*`, `.infisical.json`, `backend-config.tfvars`
- `data/` is gitignored but currently tracked files in it contain secrets (k3s tokens, SSH keys).

## Key Files

| File | Purpose |
|---|---|
| `ansible/inventory.ini` | Production server inventory (manager + agents groups) |
| `ansible/ansible.cfg` | Ansible config (nocows, python interpreter, inventory) |
| `ansible/galaxy-requirements.yml` | Required Ansible collections |
| `pyproject.toml` | Python deps (ansible, docker, passlib) via uv |
| `Makefile` | All automation targets |
| `.env.example` | Required environment variables |
| `.pre-commit-config.yaml` | Linting hooks (black, ruff, terraform fmt, shellcheck, trufflehog) |
| `terraform/cloudflare/variables.tf` | Terraform variables (API token, account ID) |
