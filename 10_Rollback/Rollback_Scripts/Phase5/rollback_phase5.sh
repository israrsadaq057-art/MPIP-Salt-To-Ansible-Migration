#!/bin/bash
# rollback_phase5.sh
# Rollback Phase 5 (Critical servers - Domain Controllers, SQL, Exchange)

set -e

PHASE5_GROUPS="domain_controllers,sql_servers,exchange_servers"
LOG_DIR="../Rollback_Plans"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/rollback_phase5_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "⚠️  ROLLBACK - PHASE 5 (CRITICAL SERVERS) ⚠️" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

read -p "Type 'CRITICAL' to confirm rollback of Phase 5: " CONFIRM
if [ "$CONFIRM" != "CRITICAL" ]; then
    echo "Rollback cancelled." | tee -a $LOG_FILE
    exit 0
fi

echo "Step 1: Restart Salt minion on critical servers (one by one)..." | tee -a $LOG_FILE

for server in $(ansible $PHASE5_GROUPS -i ../../04_Ansible_Design/Inventory/production_hosts.yml --list-hosts | tail -n +2); do
    echo "Processing: $server" | tee -a $LOG_FILE
    ansible $server -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m systemd -a "name=salt-minion state=started enabled=yes" >> $LOG_FILE 2>&1
    ansible $server -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m command -a "salt-call state.apply" >> $LOG_FILE 2>&1
    sleep 5
done

echo "Step 2: Verify Domain Controllers..." | tee -a $LOG_FILE
ansible domain_controllers -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m win_shell -a "Get-ADDomain" >> $LOG_FILE 2>&1

echo "========================================" | tee -a $LOG_FILE
echo "PHASE 5 ROLLBACK COMPLETE" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
