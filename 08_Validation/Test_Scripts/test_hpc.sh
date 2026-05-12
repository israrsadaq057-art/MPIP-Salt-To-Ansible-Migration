#!/bin/bash
# test_hpc.sh
# Validate SLURM cluster

INVENTORY="../04_Ansible_Design/Inventory/production_hosts.yml"

echo "========================================"
echo "HPC CLUSTER VALIDATION"
echo "========================================"

echo "1. SLURM node status..."
ansible slurm_controller -i $INVENTORY -m command -a "sinfo"

echo ""
echo "2. SLURM partition list..."
ansible slurm_controller -i $INVENTORY -m command -a "scontrol show partitions"

echo ""
echo "3. Submit test job..."
ansible slurm_controller -i $INVENTORY -m command -a "srun -N1 hostname"

echo ""
echo "4. Check job queue..."
ansible slurm_controller -i $INVENTORY -m command -a "squeue"

echo ""
echo "5. Check Munge status..."
ansible slurm_controller -i $INVENTORY -m command -a "systemctl status munge"

echo "========================================"
echo "HPC VALIDATION COMPLETE"
echo "========================================"
