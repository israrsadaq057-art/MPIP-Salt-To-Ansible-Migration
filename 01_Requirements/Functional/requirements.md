# Functional Requirements – Salt to Ansible Migration

## 1. Core Services (Must work exactly the same after migration)

1.1 NTP must be configured on all 1,247 servers.
1.2 All servers must sync time with the same NTP servers as before.
1.3 SSH must be accessible on port 22 for the ansible user.
1.4 Root login over SSH must stay disabled.
1.5 The same user accounts must exist on the same servers.
1.6 Sudo access must work the same way for the same users.

## 2. Storage (Must preserve all data and access)

2.1 All ZFS pools must be imported with the same names.
2.2 All ZFS datasets must keep the same mount points.
2.3 NFS exports must be identical after migration.
2.4 Same clients must have the same access to NFS shares.
2.5 iSCSI targets must keep the same IQN names.
2.6 Backup jobs must run on the same schedule.

## 3. HPC (SLURM must continue to run research jobs)

3.1 SLURM controller must recognize all 512 compute nodes.
3.2 All existing partitions (normal, long, gpu) must exist.
3.3 Submitted jobs must start and finish without changes.
3.4 Job accounting must be preserved.
3.5 GPU nodes must be accessible for GPU jobs.

## 4. GPU (NVIDIA stack must work)

4.1 NVIDIA drivers must be loaded on all 256 GPU nodes.
4.2 nvidia-smi must show all GPUs.
4.3 CUDA toolkit must be available.
4.4 cuDNN must be installed.
4.5 TensorFlow and PyTorch must work.

## 5. Kubernetes (Cluster must stay operational)

5.1 All 3 master nodes must join the cluster.
5.2 All 15 worker nodes must join the cluster.
5.3 Existing pods must keep running.
5.4 Calico networking must work the same.
5.5 Ingress must route traffic correctly.

## 6. Docker

6.1 Docker daemon must be running on all 45 Docker hosts.
6.2 Private registry must be accessible.
6.3 Existing containers must not be affected.

## 7. Monitoring

7.1 Icinga2 must monitor all 1,247 servers.
7.2 Prometheus must scrape all targets.
7.3 Grafana dashboards must show the same data.
7.4 ELK must receive logs from all servers.

## 8. Security

8.1 OSSEC agents must report to the manager.
8.2 Vault must be accessible with the same policies.
8.3 auditd must log the same events.
8.4 fail2ban must block the same IPs.

## 9. Windows Servers (79 servers)

9.1 Domain controllers must keep the same FSMO roles.
9.2 DNS records must not change.
9.3 DHCP leases must stay valid.
9.4 SQL databases must remain online.
9.5 Exchange mailboxes must be accessible.

## 10. Research Applications

10.1 Quantum toolkits (Qiskit, Cirq) must work.
10.2 Nano simulations (VASP, Quantum ESPRESSO) must run.
10.3 Bioinformatics pipelines (Nextflow) must work.

## 11. Rollback

11.1 Each phase must have a rollback procedure.
11.2 Rollback must complete within 30 minutes.
11.3 Salt must remain available until final decommission.

## 12. Zero Downtime

12.1 No phase may cause production downtime.
12.2 Maintenance windows are Saturday 02:00-06:00 only.
12.3 HPC jobs cannot be interrupted during migration.

## 13. Success Criteria

13.1 All 1,247 servers reachable via Ansible.
13.2 No configuration drift compared to Salt.
13.3 All 500+ Salt states converted.
13.4 All 15 custom modules rewritten.
13.5 Team can run Ansible without Salt.
