#!/bin/bash
# verify_connectivity.sh
# Test SSH to all 1,247 servers before migration

INVENTORY="../04_Ansible_Design/Inventory/production_hosts.yml"

echo "========================================"
echo "Connectivity Test - Ansible to all servers"
echo "Time: $(date)"
echo "========================================"

# Test ping to all hosts
ansible all -i $INVENTORY -m ping --one-line 2>/dev/null | grep -c "SUCCESS"

echo ""
echo "Testing specific groups..."

echo -n "Neubau Dach (768 servers): "
ansible neubau_dach -i $INVENTORY -m ping --one-line 2>/dev/null | grep -c "SUCCESS"

echo -n "Neubau Keller (119 servers): "
ansible neubau_keller -i $INVENTORY -m ping --one-line 2>/dev/null | grep -c "SUCCESS"

echo -n "Altbau EG (critical): "
ansible altbau_erdgeschoss -i $INVENTORY -m ping --one-line 2>/dev/null | grep -c "SUCCESS"

echo -n "Altbau OG: "
ansible altbau_obergeschoss -i $INVENTORY -m ping --one-line 2>/dev/null | grep -c "SUCCESS"

echo ""
echo "========================================"
echo "If any group shows less than expected, check connectivity"
echo "========================================"
