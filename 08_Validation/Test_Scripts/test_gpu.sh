#!/bin/bash
# test_gpu.sh
# Validate GPU nodes

INVENTORY="../04_Ansible_Design/Inventory/production_hosts.yml"

echo "========================================"
echo "GPU CLUSTER VALIDATION"
echo "========================================"

echo "1. NVIDIA driver version..."
ansible gpu_nodes[0] -i $INVENTORY -m command -a "nvidia-smi --version | head -1"

echo ""
echo "2. GPU count per node..."
ansible gpu_nodes[0] -i $INVENTORY -m command -a "nvidia-smi --query-gpu=name --format=csv,noheader | wc -l"

echo ""
echo "3. CUDA version..."
ansible gpu_nodes[0] -i $INVENTORY -m command -a "nvcc --version"

echo ""
echo "4. TensorFlow GPU test..."
ansible gpu_nodes[0] -i $INVENTORY -m command -a "python3 /tmp/test_tf.py"

echo ""
echo "5. PyTorch GPU test..."
ansible gpu_nodes[0] -i $INVENTORY -m command -a "python3 /tmp/test_pytorch.py"

echo "========================================"
echo "GPU VALIDATION COMPLETE"
echo "========================================"
