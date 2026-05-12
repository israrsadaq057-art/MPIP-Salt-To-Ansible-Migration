#!/bin/bash
# rollback_phase1.sh
# Rollback Phase 1 only (non-critical servers)

set -e

PHASE1_GROUPS="web_servers,print_servers"
LOG_DIR="../Rollback_Plans"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/rollback_phase1_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "ROLLBACK - PHASE 1 (Non-critical servers)" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

read -p "Confirm rollback of Phase 1 servers? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Rollback cancelled." | tee -a $LOG_FILE
    exit 0
fi

echo "Step 1: Restart Salt minion on Phase 1 servers..." | tee -a $LOG_FILE
ansible $PHASE1_GROUPS -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m systemd -a "name=salt-minion state=started enabled=yes" >> $LOG_FILE 2>&1

echo "Step 2: Apply Salt state to Phase 1 servers..." | tee -a $LOG_FILE
ansible $PHASE1_GROUPS -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m command -a "salt-call state.apply" >> $LOG_FILE 2>&1

echo "Step 3: Verify..." | tee -a $LOG_FILE
ansible $PHASE1_GROUPS -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m ping --one-line

echo ""
echo "========================================" | tee -a $LOG_FILE
echo "PHASE 1 ROLLBACK COMPLETE" | tee -a $LOG_FILE
echo "Log saved: $LOG_FILE" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
