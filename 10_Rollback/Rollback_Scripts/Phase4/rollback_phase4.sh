#!/bin/bash
# rollback_phase4.sh
# Rollback Phase 4 (Research servers)

set -e

PHASE4_GROUPS="quantum_research,nano_research,bio_research"
LOG_DIR="../Rollback_Plans"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/rollback_phase4_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "ROLLBACK - PHASE 4 (Research servers)" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

read -p "Confirm rollback of Phase 4 servers? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Rollback cancelled." | tee -a $LOG_FILE
    exit 0
fi

echo "Step 1: Restart Salt minion on research nodes..." | tee -a $LOG_FILE
ansible $PHASE4_GROUPS -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m systemd -a "name=salt-minion state=started enabled=yes" >> $LOG_FILE 2>&1

echo "Step 2: Apply Salt state for research applications..." | tee -a $LOG_FILE
ansible $PHASE4_GROUPS -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m command -a "salt-call state.apply research" >> $LOG_FILE 2>&1

echo "========================================" | tee -a $LOG_FILE
echo "PHASE 4 ROLLBACK COMPLETE" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
