#!/bin/bash
# deploy_phase5.sh
# Phase 5: Critical production servers
# Target: Domain controllers, SQL, Exchange, Primary storage (~115 servers)
# LAST PHASE - Proceed with extreme caution

set -e

INVENTORY="../../04_Ansible_Design/Inventory/production_hosts.yml"
LOG_DIR="../Logs"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/phase5_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "PHASE 5 DEPLOYMENT - Critical Production" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "⚠️  LAST PHASE - PROCEED WITH CAUTION ⚠️" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

PHASE5_GROUPS="domain_controllers,sql_servers,exchange_servers,primary_storage"

echo "Deploying to: $PHASE5_GROUPS" | tee -a $LOG_FILE
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
echo "Step 2: Dry run on Phase 5 servers..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/00-site.yml --check --limit "$PHASE5_GROUPS" >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Dry run passed" | tee -a $LOG_FILE
else
    echo "❌ Dry run failed" | tee -a $LOG_FILE
    exit 1
fi

read -p "Apply to Phase 5 servers? (yes/NO): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Deployment cancelled." | tee -a $LOG_FILE
    exit 0
fi

# Step 3: Apply one server at a time (critical)
echo "" | tee -a $LOG_FILE
echo "Step 3: Applying configuration one server at a time..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/00-site.yml --limit "$PHASE5_GROUPS" --serial 1 >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Phase 5 deployment successful" | tee -a $LOG_FILE
else
    echo "❌ Phase 5 deployment failed" | tee -a $LOG_FILE
    exit 1
fi

# Step 4: Final validation
echo "" | tee -a $LOG_FILE
echo "Step 4: Final validation..." | tee -a $LOG_FILE
../../08_Validation/Test_Scripts/validate_all.sh >> $LOG_FILE 2>&1

echo "" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
echo "🎉 ALL PHASES COMPLETE!" | tee -a $LOG_FILE
echo "Salt to Ansible migration finished" | tee -a $LOG_FILE
echo "Log saved: $LOG_FILE" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
