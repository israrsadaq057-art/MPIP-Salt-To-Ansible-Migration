# real_salt_states/common/ssh.sls
# SSH hardening for all 1,247 servers

ssh_pkg:
  pkg.installed:
    - name: openssh-server

ssh_config:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://common/files/sshd_config.j2
    - template: jinja
    - context:
        permit_root_login: no
        password_auth: no
        port: 22
    - require:
      - pkg: ssh_pkg

ssh_service:
  service.running:
    - name: ssh
    - enable: True
    - watch:
      - file: ssh_config
