#!/bin/bash
# test_storage.sh
# Validate ZFS, NFS, iSCSI

INVENTORY="../04_Ansible_Design/Inventory/production_hosts.yml"

echo "========================================"
echo "STORAGE VALIDATION"
echo "========================================"

echo "1. Checking ZFS pools..."
ansible neubau_keller -i $INVENTORY -m command -a "zpool list"

echo ""
echo "2. Checking ZFS datasets..."
ansible neubau_keller -i $INVENTORY -m command -a "zfs list"

echo ""
echo "3. Checking NFS exports..."
ansible neubau_keller -i $INVENTORY -m command -a "exportfs -v"

echo ""
echo "4. Testing NFS mount from client..."
ansible hpc_compute[0] -i $INVENTORY -m command -a "showmount -e storage-01.mpip-halle.de"

echo "========================================"
echo "STORAGE VALIDATION COMPLETE"
echo "========================================"
