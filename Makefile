SHELL=/bin/bash

MAKEFLAGS += -s

# Define color codes
RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[0;33m
BLUE=\033[0;34m
NC=\033[0m

ansible-local-setup:
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


ansible-system-update:
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/update.yml -i inventory.ini

ansible-system-reboot:
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/reboot.yml -i inventory.ini

ansible-system-set-ist-timezone:
	@echo -e "\n$(BLUE) [!] Activating Python venv...$(NC) \n";
	@source ./venv/bin/activate; \
	echo -e "\n$(BLUE) [!] Running playbook...$(NC) \n"; \
	cd  ansible; \
	ansible-playbook playbooks/system/set-ist-timezone.yml -i inventory.ini
	
.PHONY = ansible-local-setup ansible-system-update ansible-system-set-ist-timezone

