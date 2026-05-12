# Salt to Ansible Migration – Max Planck Institute

## Project Overview

Complete migration of 1,247 servers from SaltStack to Ansible for Max Planck Institute for Microstructure Physics, Halle.

**Status:** ✅ Complete  
**Duration:** 16 weeks  
**Downtime:** 0 minutes

## Infrastructure

- **Buildings:** Neubau (Weinberg 2) + Altbau (Weinberg 3)
- **Server Rooms:** 4 (Dach, Keller, Erdgeschoss, Obergeschoss)
- **Total Servers:** 1,247
- **Salt States:** 500+ converted
- **Custom Modules:** 15 rewritten

## Repository Structure

| Folder | Contents |
|--------|----------|
| `00_Project_Overview` | Project documentation, plan, risk assessment |
| `01_Requirements` | Functional, technical, compliance requirements |
| `02_Infrastructure_Inventory` | Server inventory, network, storage, buildings |
| `03_Salt_Analysis` | Salt states, pillars, custom modules inventory |
| `04_Ansible_Design` | Inventory files, group_vars, templates |
| `05_Conversion_Scripts` | Python scripts for Salt → Ansible conversion |
| `06_Ansible_Roles` | 22 production roles |
| `07_Ansible_Playbooks` | 7 master playbooks |
| `08_Validation` | Test scripts and validation suite |
| `09_Deployment` | 5-phase deployment scripts |
| `10_Rollback` | Rollback scripts for each phase |
| `11_Training` | Training materials |
| `12_Handover` | Final documentation |

## Key Files

- `07_Ansible_Playbooks/Production/00-site.yml` - Main playbook
- `04_Ansible_Design/Inventory/production_hosts.yml` - All 1,247 servers
- `06_Ansible_Roles/` - 22 roles (Common, Core, Storage, HPC, GPU, K8s, etc.)
- `09_Deployment/Phase_5_Critical/deploy_phase5.sh` - Critical deployment

## GitHub Actions CI/CD

This repository includes GitHub Actions workflows that:
- Validate Ansible syntax
- Check role structure
- Verify inventory file
- Validate YAML formatting

## Author

Israr Sadaq – Network Infrastructure Engineer  
📧 israrsadaq057@gmail.com  
🔗 [GitHub Profile](https://github.com/israrsadaq057-art)

## License

Internal use – Max Planck Institute for Microstructure Physics
