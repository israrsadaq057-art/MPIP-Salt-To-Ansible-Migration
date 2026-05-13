# real_salt_states/common/ntp.sls
# NTP configuration for all 1,247 servers

ntp_pkg:
  pkg.installed:
    - name: ntp

ntp_config:
  file.managed:
    - name: /etc/ntp.conf
    - source: salt://common/files/ntp.conf.j2
    - template: jinja
    - context:
        ntp_servers:
          - 0.de.pool.ntp.org
          - 1.de.pool.ntp.org
          - 2.de.pool.ntp.org
    - require:
      - pkg: ntp_pkg

ntp_service:
  service.running:
    - name: ntp
    - enable: True
    - watch:
      - file: ntp_config
