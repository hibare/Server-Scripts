SHELL=/bin/bash

MAKEFLAGS += -s

# Define color codes
RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[0;33m
BLUE=\033[0;34m
NC=\033[0m

.DEFAULT_GOAL := help
.PHONY = ansible-local-setup ansible-system-update ansible-system-set-ist-timezone help

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


ansible-system-update: ## Ansible System Update
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/update.yml -i inventory.ini

ansible-system-reboot: ## Ansible System Reboot
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/reboot.yml -i inventory.ini

ansible-system-set-ist-timezone: ## Ansible Set IST Timezone
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/set-ist-timezone.yml -i inventory.ini

ansible-system-install-backup: ## Ansible System Install Backup
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/install-backup.yml -i inventory.ini

ansible-system-install-ssh-login-notifier: ## Ansible System Install SSH Login Notifier
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/ssh-login-alert.yml -i inventory.ini
	
help: ## Help
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sed -n 's/^\(.*\): \(.*\)##\(.*\)/\1\3/p' \
	| column -t  -s ' '
