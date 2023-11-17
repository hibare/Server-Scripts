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

INVENTORY_FILE ?= inventory.ini

.PHONY: ansible-local-setup
ansible-local-setup: ## Ansible Local Setup 
	@echo -e "\n$(BLUE) [!] Checking sshpass...$(NC)"
	@which sshpass > /dev/null 2>&1 || (echo -e "\n$(BLUE) [!] Installing sshpass...$(NC) \n" && sudo apt-get install sshpass -y)

	@echo -e "\n$(BLUE) [!] Checking python3-venv...$(NC)"
	@which python3 > /dev/null 2>&1 || (echo -e "\n$(BLUE) [!] Python3 not found. Please install Python3." && exit 1)
	@@python3 -m venv -h > /dev/null 2>&1 || (echo -e "\n$(BLUE) [!] Installing python3-venv...$(NC) \n" && sudo apt-get install python3-venv -y)

	@echo -e "\n$(BLUE) [!] Creating Python venv...$(NC)";
	@python3 -m venv venv
	@echo -e "\n$(GREEN) [!] Created Python venv...$(NC)";
	@echo -e "\n$(GREEN) [!] To activate: source ./venv/bin/activate...$(NC)";
	
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC)";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Installing Python packages...$(NC)"; \
	python3 -m pip install -r ansible/requirements.txt > /dev/null; \
	python3 -m pip install -r ansible/dev-requirements.txt > /dev/null; \
	echo -e "\n$(BLUE) [!] Installing ansible galaxy mdoules...$(NC)"; \
	ansible-galaxy collection install -r ansible/galaxy-requirements.yml > /dev/null;

define run_ansible_playbook
	echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n"; \
	source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	set -o allexport; \
	source ".env"; \
	set +o allexport; \
	cd  ansible; \
	echo -e "\n$(YELLOW) [!] Using inventory file $(RED)$(INVENTORY_FILE)...$(NC) \n"; \
	ansible-playbook $(1) -i $(INVENTORY_FILE);
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

.PHONY: ansible-system-install-tailscale
ansible-system-install-tailscale: ## Ansible System Install Tailscale
	$(call run_ansible_playbook, playbooks/system/install-tailscale.yml)

.PHONY: ansible-system-join-docker-swarm
ansible-system-join-docker-swarm: ## Ansible System Join Docker Swarm
	$(call run_ansible_playbook, playbooks/system/join-docker-swarm.yml)

.PHONY: ansible-system-setup-ufw
ansible-system-setup-ufw: ## Ansible System Setup UFW
	$(call run_ansible_playbook, playbooks/system/setup-ufw.yml)

.PHONY: help
help: ## Disply this help
		@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(BCYAN)%-45s$(NC)%s\n", $$1, $$2}'
