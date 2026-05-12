# Rollback Procedures – Salt to Ansible Migration

## When to Rollback

Rollback is triggered when:

1. More than 10 servers fail to respond after Ansible run
2. SLURM jobs stop scheduling (more than 5 minutes)
3. Storage becomes unavailable (NFS exports missing)
4. Domain controllers replication fails
5. Monitoring blackout for > 15 minutes

## Rollback by Phase

### Phase 1 Rollback (Non-critical)
- Time: ~15 minutes
- Command: `./rollback_phase1.sh`
- What it does: Restarts Salt minion, applies Salt highstate to Phase 1 servers

### Phase 2 Rollback (Infrastructure)
- Time: ~20 minutes
- Command: `./rollback_phase2.sh`
- What it does: Restores DNS, DHCP, monitoring to Salt

### Phase 3 Rollback (HPC)
- Time: ~45 minutes
- Command: `./rollback_phase3.sh`
- What it does: Reverts SLURM config, restarts munge, reapplies Salt state

### Phase 4 Rollback (Research)
- Time: ~30 minutes
- Command: `./rollback_phase4.sh`
- What it does: Restores research applications to Salt

### Phase 5 Rollback (Critical)
- Time: ~60 minutes
- Command: `./rollback_phase5.sh`
- What it does: ONE SERVER AT A TIME - DCs, SQL, Exchange

### Full Rollback (All servers)
- Time: ~3 hours
- Command: `./rollback_all.sh`
- What it does: Complete revert to Salt for all 1,247 servers

## Rollback Validation

After rollback, verify:

1. `salt-key --list-all` shows all minions
2. `salt '*' test.ping` returns True
3. `salt '*' state.apply` runs without errors
4. SLURM jobs submit successfully
5. Storage mounts are accessible

## Emergency Contacts

- Primary: Israr Sadaq - [phone]
- Secondary: IT Manager - [phone]
- Escalation: Director - [phone]

## Rollback Logs

All rollback actions are logged in `10_Rollback/Rollback_Plans/logs/`
