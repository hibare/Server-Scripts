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

.PHONY: ansible-local-setup
ansible-local-setup: ## Ansible Local Setup 
	@echo -e "\n$(BLUE) [!] Installing sshpass...$(NC) \n"
	@sudo apt install sshpass -y
	@echo -e "\n$(BLUE) [!] Installing python3-venv...$(NC) \n"
	@sudo apt install python3-venv -y
	@echo -e "\n$(BLUE) [!] Creating Python venv...$(NC) \n";
	@python3 -m venv venv
	@echo -e "\n$(GREEN) [!] Created Python venv...$(NC) \n";
	@echo -e "\n$(GREEN) [!] To activate: source ./venv/bin/activate...$(NC) \n";
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Installing Python package passlib...$(NC) \n"; \
	python3 -m pip install --upgrade passlib; \
	echo -e "\n$(BLUE) [!] Installing Python package ansible...$(NC) \n"; \
	python3 -m pip install --upgrade ansible; \
	echo -e "\n$(BLUE) [!] Installing ansible galaxy mdoules...$(NC) \n"; \
	ansible-galaxy collection install -r ansible/requirements.yml;

.PHONY: ansible-system-update
ansible-system-update: ## Ansible System Update
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/update.yml -i inventory.ini

.PHONY: ansible-system-reboot
ansible-system-reboot: ## Ansible System Reboot
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/reboot.yml -i inventory.ini

.PHONY: ansible-system-set-ist-timezone
ansible-system-set-ist-timezone: ## Ansible Set IST Timezone
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/set-ist-timezone.yml -i inventory.ini

.PHONY: ansible-system-install-backup
ansible-system-install-backup: ## Ansible System Install Backup
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/install-backup.yml -i inventory.ini

.PHONY: ansible-system-install-ssh-login-notifier
ansible-system-install-ssh-login-notifier: ## Ansible System Install SSH Login Notifier
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/ssh-login-alert.yml -i inventory.ini

.PHONY: ansible-system-install-update-notifier
ansible-system-install-update-notifier: ## Ansible System Install Update Notifier
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/update-notifier.yml -i inventory.ini

.PHONY: ansible-system-push-env-vars
ansible-system-push-env-vars: ## Ansible System push env vars
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/push-env-vars.yml -i inventory.ini

.PHONY: help	
help: ## Disply this help
		@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(BCYAN)%-45s$(NC)%s\n", $$1, $$2}'
