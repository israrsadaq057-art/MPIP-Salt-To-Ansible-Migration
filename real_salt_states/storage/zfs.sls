# real_salt_states/storage/zfs.sls
# ZFS storage for 88 storage nodes (Neubau Keller)

zfs_pkg:
  pkg.installed:
    - pkgs:
      - zfsutils-linux
      - zfs-zed

zfs_pools:
  cmd.run:
    - names:
      - zpool create -f tank /dev/sdb /dev/sdc
      - zpool create -f backup /dev/sdd /dev/sde
    - unless: zpool list tank

zfs_datasets:
  cmd.run:
    - names:
      - zfs create -o mountpoint=/research tank/research
      - zfs create -o mountpoint=/hpc tank/hpc
      - zfs create -o mountpoint=/backup backup/backup
    - require:
      - cmd: zfs_pools

zfs_service:
  service.running:
    - name: zed
    - enable: True
