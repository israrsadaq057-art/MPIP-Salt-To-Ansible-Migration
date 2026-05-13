# real_salt_states/hpc/slurm.sls
# SLURM cluster for 512 compute nodes (Neubau Dach)

slurm_pkg:
  pkg.installed:
    - pkgs:
      - slurm-wlm
      - munge

munge_key:
  file.managed:
    - name: /etc/munge/munge.key
    - source: salt://hpc/files/munge.key
    - mode: 0400
    - owner: munge
    - group: munge

slurm_config:
  file.managed:
    - name: /etc/slurm-llnl/slurm.conf
    - source: salt://hpc/files/slurm.conf.j2
    - template: jinja
    - context:
        control_machine: hpc-master-01
        compute_nodes: hpc-node-[001-512]
    - require:
      - pkg: slurm_pkg
      - file: munge_key

slurm_services:
  service.running:
    - names:
      - munge
      - slurmctld
      - slurmd
    - enable: True
    - watch:
      - file: slurm_config
