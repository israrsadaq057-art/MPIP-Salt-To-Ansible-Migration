#!/bin/bash
# deploy_phase1.sh
# Phase 1: Non-critical servers
# Target: web servers, print servers, dev servers (~200 servers)
# Israr Sadaq - MPIP Halle

set -e

INVENTORY="../../04_Ansible_Design/Inventory/production_hosts.yml"
LOG_DIR="../Logs"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/phase1_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "PHASE 1 DEPLOYMENT - Non-Critical Servers" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

# Phase 1 servers: web, print, dev
PHASE1_GROUPS="web_servers,print_servers"

echo "Deploying to: $PHASE1_GROUPS" | tee -a $LOG_FILE
echo "" | tee -a $LOG_FILE

# Step 1: Syntax check
echo "Step 1: Syntax validation..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/01-core.yml --syntax-check >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Syntax check passed" | tee -a $LOG_FILE
else
    echo "❌ Syntax check failed" | tee -a $LOG_FILE
    exit 1
fi

# Step 2: Dry run
echo "" | tee -a $LOG_FILE
echo "Step 2: Dry run on Phase 1 servers..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/01-core.yml --check --limit "$PHASE1_GROUPS" >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Dry run passed" | tee -a $LOG_FILE
else
    echo "❌ Dry run failed" | tee -a $LOG_FILE
    exit 1
fi

# Step 3: Ask for confirmation
echo "" | tee -a $LOG_FILE
read -p "Apply to Phase 1 servers? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Deployment cancelled." | tee -a $LOG_FILE
    exit 0
fi

# Step 4: Apply configuration
echo "" | tee -a $LOG_FILE
echo "Step 3: Applying configuration to Phase 1 servers..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/01-core.yml --limit "$PHASE1_GROUPS" >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Phase 1 deployment successful" | tee -a $LOG_FILE
else
    echo "❌ Phase 1 deployment failed" | tee -a $LOG_FILE
    exit 1
fi

# Step 5: Validate
echo "" | tee -a $LOG_FILE
echo "Step 4: Validating Phase 1 servers..." | tee -a $LOG_FILE
ansible $PHASE1_GROUPS -i $INVENTORY -m ping --one-line | grep -c "SUCCESS"
echo "✅ Validation complete" | tee -a $LOG_FILE

echo "" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
echo "PHASE 1 COMPLETE" | tee -a $LOG_FILE
echo "Log saved: $LOG_FILE" | tee -a $LOG_FILE
echo "Wait 24 hours before Phase 2" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
