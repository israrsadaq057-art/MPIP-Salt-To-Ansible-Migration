# Technical Requirements – Salt to Ansible Migration

## 1. Control Node Requirements

1.1 AWX must run on a 3‑node Kubernetes cluster.
1.2 GitLab must run on a dedicated VM (8 vCPU, 16 GB RAM, 100 GB disk).
1.3 PostgreSQL for AWX requires 4 vCPU, 8 GB RAM, 50 GB disk.
1.4 All control nodes must be in the same network as the managed servers.
1.5 SSH connectivity from AWX to all 1,247 servers must be verified.

## 2. Target Server Prerequisites (All 1,247 servers)

2.1 Python 3.8 or higher must be installed.
2.2 The ansible user must exist with sudo NOPASSWD.
2.3 SSH key for the ansible user must be deployed.
2.4 Firewall must allow port 22 from the AWX subnet.
2.5 Network latency < 10 ms between AWX and servers.

## 3. Storage Requirements

3.1 ZFS version must be 2.1 or higher.
3.2 NFS version must be 4.2.
3.3 Backup destination must have 2x the space of source.
3.4 Tape library must have LTFS support.

## 4. Network Requirements

4.1 All 60+ switches must have SSH enabled.
4.2 Enable password must be available for Cisco devices.
4.3 SNMP must be configured for monitoring.
4.4 Bandwidth between buildings must be at least 10 Gbps.

## 5. HPC Requirements

5.1 SLURM version must be 23.02 or higher.
5.2 Munge key must be identical across all nodes.
5.3 Lustre clients must match MDS version.

## 6. GPU Requirements

6.1 NVIDIA driver version 535 or higher.
6.2 CUDA version 12.3.
6.3 cuDNN version 8.9.

## 7. Kubernetes Requirements

7.1 kubeadm version 1.28.
7.2 Calico version 3.26.
7.3 Ingress controller must support TLS 1.3.

## 8. Windows Requirements

8.1 WinRM must be enabled on all 79 Windows servers.
8.2 Kerberos authentication must work.
8.3 PowerShell 5.1 or higher.

## 9. Secrets Management

9.1 Ansible Vault password must be stored offline.
9.2 No secrets in plain text in Git.
9.3 Vault must be backed up daily.

## 10. Testing Requirements

10.1 Staging environment must mirror production at 20% scale.
10.2 All tests must pass before production rollout.
10.3 Rollback must be tested once per phase.

## 11. Monitoring Requirements

11.1 Icinga2 must alert on migration failures.
11.2 Prometheus must track playbook execution time.
11.3 Grafana dashboard must show migration progress.

## 12. Documentation Requirements

12.1 All playbooks must be commented.
12.2 Inventory must be documented.
12.3 Handover document must be completed.
