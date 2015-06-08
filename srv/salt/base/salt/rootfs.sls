#!yamlscript
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# Install rootfs file server and formulas
##

salt-rootfs:
  pkg.installed:
    - names:
      - salt
    - require_in:
      - service: salt-master
      - service: salt-minion

# rootfs configuration file
$with /etc/salt/master.d/file-directory-settings.conf:
  file:
    - absent
    - require_in:
      - file: /srv/salt/top.sls

  /etc/salt/master.d/file-directory-settings.conf:
    file.managed:
      - source: salt://salt/files/master.d/file-directory-settings.conf
      - user: root
      - group: root
      - mode: 640

# use master rootfs configuration file
$with /etc/salt/minion.d/file-directory-settings.conf.dev:
  file:
    - absent
    - require_in:
      - file: /srv/salt/top.sls

  /etc/salt/minion.d/file-directory-settings.conf:
    file.managed:
      - source: salt://salt/files/master.d/file-directory-settings.conf
      - user: root
      - group: root
      - mode: 640
