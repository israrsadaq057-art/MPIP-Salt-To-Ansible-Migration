#!/bin/bash
# rollback_all.sh
# Emergency rollback - revert ALL servers to Salt
# Israr Sadaq - MPIP Halle

set -e

LOG_DIR="../Rollback_Plans"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/rollback_all_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "⚠️  EMERGENCY ROLLBACK - ALL SERVERS ⚠️" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

read -p "ARE YOU SURE? This will revert ALL 1,247 servers to Salt. Type 'ROLLBACK' to confirm: " CONFIRM
if [ "$CONFIRM" != "ROLLBACK" ]; then
    echo "Rollback cancelled." | tee -a $LOG_FILE
    exit 0
fi

echo "" | tee -a $LOG_FILE
echo "Step 1: Stopping Ansible managed services..." | tee -a $LOG_FILE

# Stop services that Ansible might have started
ansible all -m systemd -a "name=icinga2 state=stopped" --forks 100 >> $LOG_FILE 2>&1 || true
ansible all -m systemd -a "name=prometheus state=stopped" >> $LOG_FILE 2>&1 || true
ansible all -m systemd -a "name=grafana-server state=stopped" >> $LOG_FILE 2>&1 || true

echo "Step 2: Restarting Salt minion on all servers..." | tee -a $LOG_FILE
ansible all -m systemd -a "name=salt-minion state=started enabled=yes" --forks 100 >> $LOG_FILE 2>&1

echo "Step 3: Applying Salt highstate..." | tee -a $LOG_FILE
ansible all -m command -a "salt-call state.apply" --forks 50 >> $LOG_FILE 2>&1

echo "Step 4: Verifying Salt minions..." | tee -a $LOG_FILE
salt-key --list-all

echo "" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
echo "ROLLBACK COMPLETE" | tee -a $LOG_FILE
echo "Salt is now managing all servers" | tee -a $LOG_FILE
echo "Log saved: $LOG_FILE" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
