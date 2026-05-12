# PROJECT PLAN – 16 WEEKS

## Phase 0: Preparation (Week 0)
| Task | Duration | Owner | Status |
|------|----------|-------|--------|
| Verify SSH access to all 4 server rooms | 2 days | Lead | ⬜ |
| Backup Salt master data | 1 day | Lead | ⬜ |
| Create infrastructure documentation | 2 days | Lead | ⬜ |

## Phase 1: Discovery (Weeks 1-2)
| Task | Duration | Owner | Status |
|------|----------|-------|--------|
| Complete server inventory (1,247 servers) | 3 days | Lead | ⬜ |
| Salt state catalog (500+ states) | 3 days | Lead | ⬜ |
| Custom module analysis (15 modules) | 2 days | Lead | ⬜ |
| Dependency mapping | 2 days | Lead | ⬜ |

## Phase 2: Environment Setup (Weeks 3-4)
| Task | Duration | Owner | Status |
|------|----------|-------|--------|
| Deploy AWX (Ansible Tower) | 4 days | Lead | ⬜ |
| Deploy GitLab CI/CD | 2 days | Lead | ⬜ |
| Set up Ansible Vault | 2 days | Lead | ⬜ |
| Create Ansible inventory | 2 days | Lead | ⬜ |

## Phase 3: Core Services Conversion (Weeks 5-6)
| Task | Duration | Owner | Status |
|------|----------|-------|--------|
| NTP conversion (1,247 servers) | 2 days | Lead | ⬜ |
| SSH hardening conversion | 2 days | Lead | ⬜ |
| User management conversion | 2 days | Lead | ⬜ |
| Firewall conversion | 2 days | Lead | ⬜ |
| Logging conversion | 2 days | Lead | ⬜ |

## Phase 4: Storage Conversion (Week 7-8)
| Task | Duration | Owner | Status |
|------|----------|-------|--------|
| ZFS conversion (88 nodes) | 3 days | Lead | ⬜ |
| NFS conversion | 2 days | Lead | ⬜ |
| iSCSI conversion | 2 days | Lead | ⬜ |
| Backup conversion | 3 days | Lead | ⬜ |

## Phase 5: HPC & GPU Conversion (Week 9-10)
| Task | Duration | Owner | Status |
|------|----------|-------|--------|
| SLURM controller conversion | 2 days | Lead | ⬜ |
| SLURM compute nodes (512) | 3 days | Lead | ⬜ |
| Lustre conversion | 2 days | Lead | ⬜ |
| NVIDIA/CUDA conversion (256 nodes) | 3 days | Lead | ⬜ |

## Phase 6: K8s & Docker Conversion (Week 11)
| Task | Duration | Owner | Status |
|------|----------|-------|--------|
| Kubernetes conversion (18 nodes) | 3 days | Lead | ⬜ |
| Docker conversion (45 hosts) | 2 days | Lead | ⬜ |

## Phase 7: Monitoring & Security (Week 12-13)
| Task | Duration | Owner | Status |
|------|----------|-------|--------|
| Icinga2 conversion | 2 days | Lead | ⬜ |
| Prometheus/Grafana conversion | 2 days | Lead | ⬜ |
| ELK Stack conversion | 2 days | Lead | ⬜ |
| Security tools conversion | 2 days | Lead | ⬜ |

## Phase 8: Research & Windows (Week 14)
| Task | Duration | Owner | Status |
|------|----------|-------|--------|
| Quantum research conversion | 2 days | Lead | ⬜ |
| Nano research conversion | 2 days | Lead | ⬜ |
| Bioinformatics conversion | 2 days | Lead | ⬜ |
| Windows servers conversion (79) | 2 days | Lead | ⬜ |

## Phase 9: Validation (Week 15)
| Task | Duration | Owner | Status |
|------|----------|-------|--------|
| Syntax validation | 1 day | Lead | ⬜ |
| Dry-run testing | 2 days | Lead | ⬜ |
| Staging deployment | 2 days | Lead | ⬜ |
| Functional validation | 2 days | Lead | ⬜ |
| Security validation | 1 day | Lead | ⬜ |

## Phase 10: Rollout (Week 16)
| Task | Duration | Owner | Status |
|------|----------|-------|--------|
| Phase 1: Non-critical (200 servers) | 1 day | Lead | ⬜ |
| Phase 2: Infrastructure (300 servers) | 1 day | Lead | ⬜ |
| Phase 3: HPC compute (512 servers) | 1 day | Lead | ⬜ |
| Phase 4: Research (180 servers) | 1 day | Lead | ⬜ |
| Phase 5: Critical (115 servers) | 1 day | Lead | ⬜ |
| Decommission Salt | 1 day | Lead | ⬜ |
