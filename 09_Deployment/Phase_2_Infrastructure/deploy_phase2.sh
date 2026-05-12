#!/bin/bash
# deploy_phase2.sh
# Phase 2: Infrastructure servers
# Target: DNS, DHCP, monitoring (~300 servers)

set -e

INVENTORY="../../04_Ansible_Design/Inventory/production_hosts.yml"
LOG_DIR="../Logs"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/phase2_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "PHASE 2 DEPLOYMENT - Infrastructure Servers" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

PHASE2_GROUPS="dns_servers,dhcp_servers,monitoring"

echo "Deploying to: $PHASE2_GROUPS" | tee -a $LOG_FILE
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
echo "Step 2: Dry run on Phase 2 servers..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/01-core.yml --check --limit "$PHASE2_GROUPS" >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Dry run passed" | tee -a $LOG_FILE
else
    echo "❌ Dry run failed" | tee -a $LOG_FILE
    exit 1
fi

read -p "Apply to Phase 2 servers? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Deployment cancelled." | tee -a $LOG_FILE
    exit 0
fi

# Step 3: Apply
echo "" | tee -a $LOG_FILE
echo "Step 3: Applying configuration..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/01-core.yml --limit "$PHASE2_GROUPS" >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Phase 2 deployment successful" | tee -a $LOG_FILE
else
    echo "❌ Phase 2 deployment failed" | tee -a $LOG_FILE
    exit 1
fi

echo "" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
echo "PHASE 2 COMPLETE" | tee -a $LOG_FILE
echo "Log saved: $LOG_FILE" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
