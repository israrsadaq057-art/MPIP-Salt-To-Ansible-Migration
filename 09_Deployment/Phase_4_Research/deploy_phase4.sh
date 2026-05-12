#!/bin/bash
# deploy_phase4.sh
# Phase 4: Research servers
# Target: Quantum, Nano, Bioinformatics (~180 servers)

set -e

INVENTORY="../../04_Ansible_Design/Inventory/production_hosts.yml"
LOG_DIR="../Logs"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/phase4_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "PHASE 4 DEPLOYMENT - Research Servers" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

PHASE4_GROUPS="quantum_research,nano_research,bio_research"

echo "Deploying to: $PHASE4_GROUPS" | tee -a $LOG_FILE
echo "" | tee -a $LOG_FILE

# Step 1: Syntax check
ansible-playbook ../../07_Ansible_Playbooks/Production/00-site.yml --syntax-check >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Syntax check passed" | tee -a $LOG_FILE
else
    echo "❌ Syntax check failed" | tee -a $LOG_FILE
    exit 1
fi

# Step 2: Dry run
echo "" | tee -a $LOG_FILE
echo "Step 2: Dry run on Phase 4 servers..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/00-site.yml --check --limit "$PHASE4_GROUPS" >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Dry run passed" | tee -a $LOG_FILE
else
    echo "❌ Dry run failed" | tee -a $LOG_FILE
    exit 1
fi

read -p "Apply to Phase 4 servers? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Deployment cancelled." | tee -a $LOG_FILE
    exit 0
fi

# Step 3: Apply
echo "" | tee -a $LOG_FILE
echo "Step 3: Applying configuration..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/00-site.yml --limit "$PHASE4_GROUPS" >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Phase 4 deployment successful" | tee -a $LOG_FILE
else
    echo "❌ Phase 4 deployment failed" | tee -a $LOG_FILE
    exit 1
fi

echo "" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
echo "PHASE 4 COMPLETE" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
