#!/bin/bash
# backup_salt.sh
# Backup Salt master before migration
# Israr Sadaq - 2026

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backup/salt_backups"
SALT_DIR="/srv/salt"
PILLAR_DIR="/srv/pillar"

echo "========================================"
echo "Salt Backup Script - Israr"
echo "Date: $DATE"
echo "========================================"

# Create backup directory
mkdir -p $BACKUP_DIR

# Backup Salt states
echo "Backing up Salt states from $SALT_DIR"
tar -czf $BACKUP_DIR/salt_states_$DATE.tar.gz $SALT_DIR

# Backup Pillar
echo "Backing up Pillar from $PILLAR_DIR"
tar -czf $BACKUP_DIR/salt_pillar_$DATE.tar.gz $PILLAR_DIR

# List backups
echo ""
echo "Backup files created:"
ls -lh $BACKUP_DIR/*$DATE*

echo ""
echo "Backup complete. Store these files safely."
echo "========================================"
