#!/bin/bash
# validate_all.sh
# Complete validation suite - runs all tests
# Israr Sadaq - MPIP Halle

set -e

INVENTORY="../04_Ansible_Design/Inventory/production_hosts.yml"
LOG_DIR="../08_Validation/Test_Reports"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/validation_$TIMESTAMP.log"

mkdir -p $LOG_DIR

echo "========================================" | tee -a $LOG_FILE
echo "SALT TO ANSIBLE MIGRATION - VALIDATION" | tee -a $LOG_FILE
echo "Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

# Track failures
FAILED=0

# Test 1: Syntax validation
echo "" | tee -a $LOG_FILE
echo "TEST 1: Ansible Syntax Validation" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE
if ansible-playbook ../07_Ansible_Playbooks/Production/00-site.yml --syntax-check >> $LOG_FILE 2>&1; then
    echo "✅ Syntax check passed" | tee -a $LOG_FILE
else
    echo "❌ Syntax check FAILED" | tee -a $LOG_FILE
    FAILED=$((FAILED+1))
fi

# Test 2: Dry-run on staging
echo "" | tee -a $LOG_FILE
echo "TEST 2: Dry-run on Staging" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE
if ansible-playbook ../07_Ansible_Playbooks/Production/01-core.yml --check --limit staging >> $LOG_FILE 2>&1; then
    echo "✅ Dry-run passed" | tee -a $LOG_FILE
else
    echo "❌ Dry-run FAILED" | tee -a $LOG_FILE
    FAILED=$((FAILED+1))
fi

# Test 3: Ping all servers
echo "" | tee -a $LOG_FILE
echo "TEST 3: Connectivity to all 1,247 servers" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE
PING_RESULT=$(ansible all -i $INVENTORY -m ping --one-line 2>/dev/null | grep -c "SUCCESS" || echo "0")
echo "Servers reachable: $PING_RESULT / 1247" | tee -a $LOG_FILE
if [ "$PING_RESULT" -eq "1247" ]; then
    echo "✅ All servers reachable" | tee -a $LOG_FILE
else
    echo "❌ Some servers unreachable" | tee -a $LOG_FILE
    FAILED=$((FAILED+1))
fi

# Test 4: NTP sync
echo "" | tee -a $LOG_FILE
echo "TEST 4: NTP Synchronization" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE
NTP_OK=$(ansible all -i $INVENTORY -m command -a "timedatectl show --property=NTPSynchronized --value" 2>/dev/null | grep -c "yes" || echo "0")
echo "NTP synced: $NTP_OK / 1247" | tee -a $LOG_FILE
if [ "$NTP_OK" -eq "1247" ]; then
    echo "✅ NTP sync OK on all servers" | tee -a $LOG_FILE
else
    echo "⚠️ Some servers NTP not synced" | tee -a $LOG_FILE
fi

# Test 5: SSH access
echo "" | tee -a $LOG_FILE
echo "TEST 5: SSH Access" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE
SSH_OK=$(ansible all -i $INVENTORY -m wait_for -a "port=22 timeout=5" 2>/dev/null | grep -c "SUCCESS" || echo "0")
echo "SSH accessible: $SSH_OK / 1247" | tee -a $LOG_FILE

# Test 6: Storage validation
echo "" | tee -a $LOG_FILE
echo "TEST 6: Storage Layer" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE
if ansible neubau_keller -i $INVENTORY -m command -a "zpool list" >> $LOG_FILE 2>&1; then
    echo "✅ ZFS pools OK" | tee -a $LOG_FILE
else
    echo "❌ ZFS pools FAILED" | tee -a $LOG_FILE
    FAILED=$((FAILED+1))
fi

# Test 7: SLURM validation
echo "" | tee -a $LOG_FILE
echo "TEST 7: SLURM Cluster" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE
if ansible slurm_controller -i $INVENTORY -m command -a "sinfo" >> $LOG_FILE 2>&1; then
    echo "✅ SLURM controller OK" | tee -a $LOG_FILE
else
    echo "❌ SLURM controller FAILED" | tee -a $LOG_FILE
    FAILED=$((FAILED+1))
fi

# Test 8: GPU validation
echo "" | tee -a $LOG_FILE
echo "TEST 8: GPU Nodes" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE
GPU_COUNT=$(ansible gpu_nodes -i $INVENTORY -m command -a "nvidia-smi --query-gpu=name --format=csv,noheader | wc -l" 2>/dev/null | grep -v "CHANGED" | awk '{sum+=$1} END {print sum}')
echo "Total GPUs detected: $GPU_COUNT" | tee -a $LOG_FILE
if [ "$GPU_COUNT" -gt "0" ]; then
    echo "✅ GPUs detected" | tee -a $LOG_FILE
else
    echo "❌ No GPUs detected" | tee -a $LOG_FILE
    FAILED=$((FAILED+1))
fi

# Summary
echo "" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
echo "VALIDATION COMPLETE" | tee -a $LOG_FILE
echo "Failed tests: $FAILED" | tee -a $LOG_FILE
echo "Log saved: $LOG_FILE" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

if [ $FAILED -eq 0 ]; then
    exit 0
else
    exit 1
fi
