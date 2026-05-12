#!/bin/bash
# test_network.sh
# Validate network connectivity between buildings

INVENTORY="../04_Ansible_Design/Inventory/production_hosts.yml"

echo "========================================"
echo "NETWORK VALIDATION"
echo "========================================"

echo "1. Latency between Neubau Dach and Keller..."
ansible neubau_dach[0] -i $INVENTORY -m command -a "ping -c 3 storage-01.mpip-halle.de"

echo ""
echo "2. Latency between Neubau and Altbau..."
ansible neubau_dach[0] -i $INVENTORY -m command -a "ping -c 3 dc01.mpip-halle.de"

echo ""
echo "3. Bandwidth test (iperf) between Dach and Keller..."
ansible neubau_dach[0] -i $INVENTORY -m command -a "iperf3 -c storage-01.mpip-halle.de -t 5"

echo "========================================"
echo "NETWORK VALIDATION COMPLETE"
echo "========================================"
