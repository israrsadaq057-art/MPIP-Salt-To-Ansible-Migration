#!/bin/bash
# rollback_phase2.sh
# Rollback Phase 2 (infrastructure servers)

set -e

PHASE2_GROUPS="dns_servers,dhcp_servers"
LOG_DIR="../Rollback_Plans"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/rollback_phase2_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "ROLLBACK - PHASE 2 (Infrastructure servers)" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

read -p "Confirm rollback of Phase 2 servers? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Rollback cancelled." | tee -a $LOG_FILE
    exit 0
fi

echo "Step 1: Restart Salt minion..." | tee -a $LOG_FILE
ansible $PHASE2_GROUPS -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m systemd -a "name=salt-minion state=started enabled=yes" >> $LOG_FILE 2>&1

echo "Step 2: Apply Salt state..." | tee -a $LOG_FILE
ansible $PHASE2_GROUPS -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m command -a "salt-call state.apply" >> $LOG_FILE 2>&1

echo "Step 3: Verify DNS resolution..." | tee -a $LOG_FILE
ansible $PHASE2_GROUPS[0] -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m command -a "nslookup google.com" >> $LOG_FILE 2>&1

echo "========================================" | tee -a $LOG_FILE
echo "PHASE 2 ROLLBACK COMPLETE" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
