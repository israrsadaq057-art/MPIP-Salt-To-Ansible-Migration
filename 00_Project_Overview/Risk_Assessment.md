# RISK ASSESSMENT MATRIX

## Risk Levels
- **Critical (5)** – Will stop the project
- **High (4)** – Major delay, requires immediate action
- **Medium (3)** – Manageable with mitigation
- **Low (2)** – Acceptable risk
- **Very Low (1)** – Monitor only

## Risk Register

| ID | Risk Description | Probability | Impact | Score | Mitigation | Owner |
|----|-----------------|-------------|--------|-------|-------------|-------|
| R-001 | Salt master failure during migration | Low (0.1) | Critical (5) | 0.5 | Daily backups, standby master | Lead |
| R-002 | Network outage during Ansible rollout | Medium (0.3) | High (4) | 1.2 | OOB management, local fallback | Network |
| R-003 | HPC job failures after SLURM conversion | Medium (0.3) | High (4) | 1.2 | 7-day staging validation | HPC Team |
| R-004 | Database corruption during migration | Low (0.1) | Critical (5) | 0.5 | Pre-backup, PIT recovery | DBA |
| R-005 | License server outage | Low (0.1) | High (4) | 0.4 | License backup servers | HPC Team |
| R-006 | Rooftop temperature spike | Medium (0.4) | Medium (3) | 1.2 | Migrate early morning, monitor | Facilities |
| R-007 | SSH key distribution failure | Low (0.2) | High (4) | 0.8 | Multiple auth methods | Lead |
| R-008 | Ansible Vault password loss | Very Low (0.05) | Critical (5) | 0.25 | Multiple secure backups | Security |
| R-009 | Custom module compatibility | High (0.5) | Medium (3) | 1.5 | Rewrite and test first | Lead |
| R-010 | Storage array failure | Low (0.1) | Critical (5) | 0.5 | RAID, offsite backups | Storage |

## Risk Response Plans

### R-003: HPC Job Failures
1. **Detection**: Monitor SLURM job queue
2. **Response**: Stop migration, revert to Salt
3. **Recovery**: Restore from backup, analyze failure
4. **Prevention**: Run 1000 test jobs before migration

### R-006: Rooftop Temperature
1. **Detection**: Temperature sensors every 5 minutes
2. **Response**: Pause migration if temp > 30°C
3. **Resume**: When temp < 28°C for 30 minutes
4. **Prevention**: Schedule migrations at 4 AM

## Risk Heat Map
Impact
↑
5 │ R-001 R-004 R-010
│ R-008
4 │ R-002 R-003 R-005 R-007
│ R-009
3 │
2 │
1 │ R-006
└────────────────────────→ Probability
1 2 3 4 5

text
