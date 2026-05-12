# Compliance Requirements – Salt to Ansible Migration

## 1. GDPR (General Data Protection Regulation)

1.1 Research data cannot be exposed during migration.
1.2 Access logs must be preserved for 90 days.
1.3 No data may leave the institute network.
1.4 All configuration files containing personal data must be encrypted.

## 2. DFG (German Research Foundation) Requirements

2.1 Research data must remain accessible during migration.
2.2 Project data retention period is 10 years.
2.3 Migration must not affect active grants.
2.4 Audit trail of all configuration changes must be kept.

## 3. Internal Security Policies

3.1 No plain text passwords in any file.
3.2 SSH keys must be stored in Vault.
3.3 Ansible playbooks must pass security scan.
3.4 Admin access to AWX requires MFA.
3.5 All changes must be approved by IT Manager.

## 4. Audit Requirements

4.1 Every Ansible run must be logged.
4.2 Who ran what playbook, when, on which servers.
4.3 Logs must be stored for 1 year.
4.4 Weekly compliance report must be generated.

## 5. Backup & Recovery Compliance

5.1 Daily backup of all Ansible configurations.
5.2 Backup retention: 90 days.
5.3 Offsite backup: Leipzig data center.
5.4 Restore test every month.

## 6. Change Management

6.1 Every phase requires a change request.
6.2 Change requests must be approved by IT Manager.
6.3 Emergency changes allowed only with director approval.
6.4 Post‑change review required after each phase.

## 7. Access Control

7.1 AWX must be integrated with Active Directory.
7.2 Roles: admin, operator, viewer, auditor.
7.3 Admin access only from IT subnet (10.10.40.0/24).
7.4 Session timeout after 30 minutes inactivity.

## 8. Incident Response

8.1 Security incident during migration → stop migration.
8.2 Notify security officer immediately.
8.3 Preserve all logs for investigation.
8.4 Restore from backup if needed.

## 9. Data Protection

9.1 No research data on control nodes.
9.2 Temporary files must be deleted after playbook run.
9.3 Encrypted channels only (SSH, HTTPS).

## 10. Sign‑off Requirements

10.1 Each phase needs sign‑off from IT Manager.
10.2 Final handover needs director approval.
10.3 All documentation must be reviewed before closing.
