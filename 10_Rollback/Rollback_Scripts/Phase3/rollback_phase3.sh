#!/bin/bash
# rollback_phase3.sh
# Rollback Phase 3 (HPC compute nodes)

set -e

PHASE3_GROUPS="hpc_compute,gpu_nodes"
LOG_DIR="../Rollback_Plans"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/rollback_phase3_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "ROLLBACK - PHASE 3 (HPC Compute + GPU nodes)" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

read -p "Confirm rollback of Phase 3 servers? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Rollback cancelled." | tee -a $LOG_FILE
    exit 0
fi

echo "Step 1: Restart Salt minion on HPC nodes..." | tee -a $LOG_FILE
ansible $PHASE3_GROUPS -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m systemd -a "name=salt-minion state=started enabled=yes" --forks 100 >> $LOG_FILE 2>&1

echo "Step 2: Apply Salt state (SLURM config)..." | tee -a $LOG_FILE
ansible $PHASE3_GROUPS -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m command -a "salt-call state.apply slurm" --forks 50 >> $LOG_FILE 2>&1

echo "Step 3: Verify SLURM nodes..." | tee -a $LOG_FILE
ansible slurm_controller -i ../../04_Ansible_Design/Inventory/production_hosts.yml -m command -a "sinfo" >> $LOG_FILE 2>&1

echo "========================================" | tee -a $LOG_FILE
echo "PHASE 3 ROLLBACK COMPLETE" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
