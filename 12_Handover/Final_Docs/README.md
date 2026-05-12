# MPIP Halle – Ansible Infrastructure Handover

## Welcome to the Ansible team!

This directory contains everything you need to manage the infrastructure.

## Quick Links

| Document | Purpose |
|----------|---------|
| [final_report.md](final_report.md) | Complete migration report |
| [inventory_reference.md](inventory_reference.md) | All 1,247 servers |
| [playbook_reference.md](playbook_reference.md) | How to run playbooks |
| [troubleshooting.md](troubleshooting.md) | Common issues and fixes |

## Access

| System | URL | Credentials |
|--------|-----|-------------|
| AWX | https://awx.mpip-halle.de | Your AD credentials |
| GitLab | https://gitlab.mpip-halle.de | Your AD credentials |
| Ansible Vault | /etc/ansible/vault/ | Ask IT Manager for password |

## Daily Operations

```bash
# Check all servers are reachable
ansible all -m ping

# Run full deployment
ansible-playbook /etc/ansible/playbooks/00-site.yml

# Run only core services
ansible-playbook /etc/ansible/playbooks/01-core.yml

# Check service status on all servers
ansible all -m systemd -a "name=ntp state=started"
