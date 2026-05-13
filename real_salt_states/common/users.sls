# real_salt_states/common/users.sls
# User management with LDAP for 1,247 servers

ldap_pkg:
  pkg.installed:
    - pkgs:
      - libnss-ldap
      - libpam-ldap
      - nscd

ldap_config:
  file.managed:
    - name: /etc/ldap.conf
    - source: salt://common/files/ldap.conf.j2
    - template: jinja
    - context:
        ldap_server: ldap.mpip-halle.de
        base_dn: dc=mpip-halle,dc=de
    - require:
      - pkg: ldap_pkg

nscd_service:
  service.running:
    - name: nscd
    - enable: True
    - watch:
      - file: ldap_config

admin_users:
  user.present:
    - names:
      - israr
      - hpcadmin
      - storageadmin
    - groups: sudo
    - shell: /bin/bash
