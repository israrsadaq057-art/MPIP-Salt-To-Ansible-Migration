# SALT TO ANSIBLE MIGRATION
## Max Planck Institute for Microstructure Physics – Halle (Saale)

### Project Overview

| Item | Value |
|------|-------|
| **Project Name** | Salt to Ansible Migration |
| **Institute** | Max Planck Institute for Microstructure Physics |
| **Location** | Halle (Saale), Germany |
| **Buildings** | Neubau (Weinberg 2) + Altbau (Weinberg 3) |
| **Server Rooms** | 4 (Dach, Keller, Erdgeschoss, Obergeschoss) |
| **Total Servers** | 1,247 |
| **Salt States** | 500+ |
| **Custom Modules** | 15 |
| **Duration** | 16 Weeks |
| **Migration Type** | Zero Downtime, Phased Rollout |

### Building Details

#### Neubau (New Building) – Weinberg 2
- **DACH (Rooftop)** – HPC compute nodes (512), GPU nodes (256)
- **KELLER (Basement)** – Storage arrays (5 PB), Backup servers, Tape library

#### Altbau (Old Building) – Weinberg 3
- **ERDGESCHOSS (Ground Floor)** – Domain controllers (4), DNS/DHCP (6), File storage, SQL servers (12), Exchange (4)
- **OBERGESCHOSS (Upper Floor)** – Kubernetes (18 nodes), Docker (45 hosts), Web servers (35), Monitoring stack

### Success Criteria
- [ ] All 1,247 servers migrated with zero downtime
- [ ] All 500+ Salt states converted to Ansible
- [ ] All 15 custom modules rewritten
- [ ] All validation tests passing
- [ ] Team trained on Ansible operations

### Contact
- **Project Lead**: Network Infrastructure Engineer
- **Email**: israrsadaq057@gmail.com
