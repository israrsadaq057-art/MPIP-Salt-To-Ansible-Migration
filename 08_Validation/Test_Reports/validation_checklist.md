# Validation Checklist – Pre and Post Migration

## Pre-Migration Validation (Before Ansible rollout)

- [ ] All 1,247 servers reachable via SSH from control node
- [ ] Python 3.8+ installed on all servers
- [ ] ansible user exists with sudo NOPASSWD on all servers
- [ ] SSH keys distributed to all servers
- [ ] Salt master accessible and minions responding
- [ ] Full backup of /srv/salt and /srv/pillar completed
- [ ] Staging environment mirrors production (250 servers)
- [ ] All 500+ Salt states documented
- [ ] All 15 custom modules analyzed

## Core Services Validation

- [ ] NTP sync OK on all servers
- [ ] DNS resolution working
- [ ] SSH access working for ansible user
- [ ] Firewall rules applied correctly
- [ ] Logs forwarding to central syslog server

## Storage Validation

- [ ] ZFS pools imported successfully
- [ ] ZFS datasets mounted correctly
- [ ] NFS exports accessible from clients
- [ ] iSCSI targets reachable
- [ ] Backup jobs running on schedule

## HPC Validation

- [ ] SLURM controller running
- [ ] 512 compute nodes joined cluster
- [ ] Test job submitted and completed
- [ ] Munge authentication working
- [ ] Lustre filesystem mounted

## GPU Validation

- [ ] NVIDIA drivers loaded on all 256 GPU nodes
- [ ] CUDA toolkit installed
- [ ] nvidia-smi shows all GPUs
- [ ] TensorFlow detects GPU
- [ ] PyTorch detects GPU

## Kubernetes Validation

- [ ] 3 master nodes ready
- [ ] 15 worker nodes ready
- [ ] Calico networking operational
- [ ] Test pod deployed successfully

## Monitoring Validation

- [ ] Icinga2 master running
- [ ] All agents reporting
- [ ] Prometheus targets scraping
- [ ] Grafana dashboards displaying data

## Post-Migration Validation (After Ansible rollout)

- [ ] Ansible runs without errors
- [ ] All 1,247 servers under Ansible management
- [ ] No configuration drift
- [ ] Salt master decommissioned
- [ ] Backup of final configurations completed
- [ ] Documentation handed over
- [ ] Team training completed

## Sign-off

- **Validated by**: _____________
- **Date**: _____________
- **Approved for production**: ☐ Yes ☐ No
