SHELL=/bin/bash

MAKEFLAGS += -s

# Regular Colors
BLACK=\033[0;30m
RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[0;33m
BLUE=\033[0;34m
PURPLE=\033[0;35m
CYAN=\033[0;36m
WHITE=\033[0;37m

# Bold
BBLACK=\033[1;30m
BRED=\033[1;31m
BGREEN=\033[1;32m
BYELLOW=\033[1;33m
BBLUE=\033[1;34m
BPURPLE=\033[1;35m
BCYAN=\033[1;36m
BWHITE=\033[1;37m

# No color (Reset)
NC=\033[0m

.DEFAULT_GOAL := help

INFISICAL_CMD=infisical --telemetry=false
INFISICAL_RUN_CMD=$(INFISICAL_CMD) run --env=prod --path=/server

INVENTORY_FILE ?= inventory.ini

include .env
export $(shell sed 's/=.*//' .env)

.PHONY: local-setup
local-setup: ## Local Setup 
	@echo -e "\n$(BLUE) [!] Checking sshpass...$(NC)"
	@which sshpass > /dev/null 2>&1 || (echo -e "\n$(BLUE) [!] Installing sshpass...$(NC) \n" && sudo apt-get install sshpass -y)

	@echo -e "\n$(BLUE) [!] Checking infisical...$(NC)"
	@which infisical > /dev/null 2>&1 || (echo -e "\n$(BLUE) [!] Installing infisical...$(NC) \n" && curl -1sLf 'https://dl.cloudsmith.io/public/infisical/infisical-cli/setup.deb.sh' | sudo -E bash && sudo apt update -qq && sudo apt install -y -qq infisical)

	@echo -e "\n$(BLUE) [!] Initialize infisical...$(NC)"
	@$(INFISICAL_CMD) init

	@echo -e "\n$(BLUE) [!] Checking poetry...$(NC)"
	@which poetry > /dev/null 2>&1 || (echo -e "\n$(BLUE) [!] Installing poetry...$(NC) \n" && curl -sSL https://install.python-poetry.org | python3 -)
	
	echo -e "\n$(BLUE) [!] Installing Python packages...$(NC)"; \
	poetry install; \
	echo -e "\n$(BLUE) [!] Installing ansible galaxy mdoules...$(NC)"; \
	poetry run ansible-galaxy collection install -r ansible/galaxy-requirements.yml --force> /dev/null;

	@echo -e "\n$(BLUE) [!] installing terraform...$(NC)"; \
	wget -qO- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $$(lsb_release -cs) test" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null && \
	sudo apt-get update -qq && \
	sudo apt-get install -y -qq terraform > /dev/null;


define run_ansible_playbook
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd ansible; \
	echo -e "\n$(YELLOW) [!] Using inventory file $(RED)$(INVENTORY_FILE)...$(NC) \n"; \
	$(INFISICAL_RUN_CMD) -- poetry run ansible-playbook $(1) -i $(INVENTORY_FILE);
endef

.PHONY: ansible-system-update
ansible-system-update: ## Ansible System Update
	$(call run_ansible_playbook, playbooks/system/update.yml)

.PHONY: ansible-ssytem-reboot-notifier
ansible-system-reboot-notifier: ## Ansible System Reboot Notifier
	$(call run_ansible_playbook, playbooks/system/reboot-notifier.yml)
	
.PHONY: ansible-system-reboot
ansible-system-reboot: ## Ansible System Reboot
	$(call run_ansible_playbook, playbooks/system/reboot.yml)

.PHONY: ansible-system-set-timezone
ansible-system-set-timezone: ## Ansible Set IST Timezone
	$(call run_ansible_playbook, playbooks/system/set-timezone.yml)

.PHONY: ansible-system-install-backup
ansible-system-install-backup: ## Ansible System Install Backup
	$(call run_ansible_playbook, playbooks/system/install-backup.yml)

.PHONY: ansible-system-install-ssh-login-notifier
ansible-system-install-ssh-login-notifier: ## Ansible System Install SSH Login Notifier
	$(call run_ansible_playbook, playbooks/system/ssh-login-alert.yml)

.PHONY: ansible-system-install-update-notifier
ansible-system-install-update-notifier: ## Ansible System Install Update Notifier
	$(call run_ansible_playbook, playbooks/system/update-notifier.yml)

.PHONY: ansible-system-push-env-vars
ansible-system-push-env-vars: ## Ansible System push env vars
	$(call run_ansible_playbook, playbooks/system/push-env-vars.yml)

.PHONY: ansible-system-docker-stack-update
ansible-system-docker-stack-update: ## Ansible System Docker Stack Update
	$(call run_ansible_playbook, playbooks/system/docker-stack-update.yml)

.PHONY: ansible-system-docker-prune
ansible-system-docker-prune: ## Ansible System Docker Prune
	$(call run_ansible_playbook, playbooks/system/docker-prune.yml)

.PHONY: ansible-system-new-user
ansible-system-new-user: ## Ansible System New User
	$(call run_ansible_playbook, playbooks/system/new-user.yml)

.PHONY: ansible-system-install-docker
ansible-system-install-docker: ## Ansible System Install Docker
	$(call run_ansible_playbook, playbooks/system/install-docker.yml)

.PHONY : ansible-system-uninstall-docker
ansible-system-uninstall-docker: ## Ansible System Uninstall Docker
	$(call run_ansible_playbook, playbooks/system/uninstall-docker.yml)

.PHONY: ansible-system-install-tailscale
ansible-system-install-tailscale: ## Ansible System Install Tailscale
	$(call run_ansible_playbook, playbooks/system/install-tailscale.yml)

.PHONY: ansible-system-uninstall-tailscale
ansible-system-uninstall-tailscale: ## Ansible System Uninstall Tailscale
	$(call run_ansible_playbook, playbooks/system/uninstall-tailscale.yml)
	
.PHONY: ansible-system-join-docker-swarm
ansible-system-join-docker-swarm: ## Ansible System Join Docker Swarm
	$(call run_ansible_playbook, playbooks/system/join-docker-swarm.yml)

.PHONY: ansible-system-setup-ufw
ansible-system-setup-ufw: ## Ansible System Setup UFW
	$(call run_ansible_playbook, playbooks/system/setup-ufw.yml)

.PHONY: ansible-system-create-swap-file
ansible-system-create-swap-file: ## Ansible System Create Swap File
	$(call run_ansible_playbook, playbooks/system/create-swap-file.yml)

.PHONY: ansible-system-install-grafana-agent
ansible-system-install-grafana-agent: ## Ansible System Install Grafana Agent
	$(call run_ansible_playbook, playbooks/system/install-grafana-agent.yml)
	
.PHONY: ansible-system-uninstall-grafana-agent
ansible-system-uninstall-grafana-agent: ## Ansible System Uninstall Grafana Agent
	$(call run_ansible_playbook, playbooks/system/uninstall-grafana-agent.yml)

.PHONY: ansible-system-install-grafana-alloy
ansible-system-install-grafana-alloy: ## Ansible System Install Grafana alloy
	$(call run_ansible_playbook, playbooks/system/install-grafana-alloy.yml)

# ToDO: Add uninstall playbook
# https://galaxy.ansible.com/ui/repo/published/grafana/grafana/content/role/alloy/

.PHONY: ansible-system-install-timesync
ansible-system-install-timesync: ## Ansible System Install Timesync
	$(call run_ansible_playbook, playbooks/system/install-timesync.yml)

.PHONY: ansible-infisical-agent
ansible-infisical-agent: ## Ansible Infisical Agent
	$(call run_ansible_playbook, playbooks/system/configure-infisical-agent.yml)

.PHONY: ansible-system-setup-docker-loki-plugin 
ansible-system-setup-docker-loki-plugin: ## Ansible System Setup Docker Loki Plugin
	$(call run_ansible_playbook, playbooks/system/setup-docker-loki-plugin.yml)

.PHONY: ansible-install-s3-media-point
ansible-install-s3-media-point: ## Ansible Install S3 Media Point
	$(call run_ansible_playbook, playbooks/system/install-s3-media-point.yml)

.PHONY: ansible-uninstall-s3-media-point
ansible-uninstall-s3-media-point: ## Ansible Uninstall S3 Media Point
	$(call run_ansible_playbook, playbooks/system/uninstall-s3-media-point.yml)

.PHONY: tf-cf-apply
tf-cf-apply: ## Terraform Cloudflare Apply
	cd terraform/cloudflare && \
	terraform init && \
	terraform apply 

.PHONY: help
help: ## Disply this help
	@sed \
		-e '/^[a-zA-Z0-9_\-]*:.*##/!d' \
		-e 's/:.*##\s*/:/' \
		-e 's/^\(.\+\):\(.*\)/$(shell tput setaf 6)\1$(shell tput sgr0):\2/' \
		$(MAKEFILE_LIST) | column -c2 -t -s :