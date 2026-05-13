# real_salt_states/gpu/nvidia.sls
# NVIDIA drivers for 256 GPU nodes

nvidia_pkg:
  pkg.installed:
    - name: nvidia-driver-535

blacklist_nouveau:
  file.managed:
    - name: /etc/modprobe.d/blacklist-nouveau.conf
    - contents:
        - blacklist nouveau
        - options nouveau modeset=0

nvidia_persistenced:
  service.running:
    - name: nvidia-persistenced
    - enable: True
    - require:
      - pkg: nvidia_pkg
