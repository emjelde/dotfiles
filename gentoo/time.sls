timezone:
  timezone.system:
    - name: America/Los_Angeles

ntp:
  pkg.installed:
    - name: net-misc/chrony
  service.running:
    - name: chronyd
    - enable: true
    - require:
      - pkg: ntp
