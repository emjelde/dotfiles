gentools:
  pkg.installed:
    - names:
      - app-portage/genlop
      - app-portage/gentoolkit

eix:
  pkg.installed:
    - name: app-portage/eix
  file.directory:
    - name: /var/cache/eix
    - user: portage
    - group: portage
    - require:
      - pkg: eix