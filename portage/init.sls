include:
  - .useflags

gentools:
  pkg.installed:
    - names:
      - app-portage/cpuid2cpuflags
      - app-portage/genlop
      - app-portage/gentoolkit
      - app-portage/mirrorselect

eix:
  pkg.installed:
    - name: app-portage/eix
  file.directory:
    - name: /var/cache/eix
    - user: portage
    - group: portage
    - require:
      - pkg: eix
