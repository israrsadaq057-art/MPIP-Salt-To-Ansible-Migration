#!/bin/bash
# deploy_phase3.sh
# Phase 3: HPC compute nodes (most critical for research)
# Target: 512 SLURM compute nodes + 256 GPU nodes

set -e

INVENTORY="../../04_Ansible_Design/Inventory/production_hosts.yml"
LOG_DIR="../Logs"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/phase3_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "PHASE 3 DEPLOYMENT - HPC Compute Nodes" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

PHASE3_GROUPS="hpc_compute,gpu_nodes"

echo "Deploying to: $PHASE3_GROUPS (768 servers)" | tee -a $LOG_FILE
echo "" | tee -a $LOG_FILE

# Step 1: Syntax check
echo "Step 1: Syntax validation..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/03-hpc.yml --syntax-check >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Syntax check passed" | tee -a $LOG_FILE
else
    echo "❌ Syntax check failed" | tee -a $LOG_FILE
    exit 1
fi

# Step 2: Dry run
echo "" | tee -a $LOG_FILE
echo "Step 2: Dry run on Phase 3 servers..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/03-hpc.yml --check --limit "$PHASE3_GROUPS" >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Dry run passed" | tee -a $LOG_FILE
else
    echo "❌ Dry run failed" | tee -a $LOG_FILE
    exit 1
fi

read -p "Apply to Phase 3 servers? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Deployment cancelled." | tee -a $LOG_FILE
    exit 0
fi

# Step 3: Apply in batches (50 at a time)
echo "" | tee -a $LOG_FILE
echo "Step 3: Applying configuration in batches..." | tee -a $LOG_FILE
ansible-playbook ../../07_Ansible_Playbooks/Production/03-hpc.yml --limit "$PHASE3_GROUPS" --serial 50 >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Phase 3 deployment successful" | tee -a $LOG_FILE
else
    echo "❌ Phase 3 deployment failed" | tee -a $LOG_FILE
    exit 1
fi

# Step 4: Validate SLURM
echo "" | tee -a $LOG_FILE
echo "Step 4: Validating SLURM cluster..." | tee -a $LOG_FILE
ansible slurm_controller -i $INVENTORY -m command -a "sinfo" >> $LOG_FILE 2>&1

echo "" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
echo "PHASE 3 COMPLETE" | tee -a $LOG_FILE
echo "Log saved: $LOG_FILE" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
