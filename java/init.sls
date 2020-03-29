jdk:
  pkg.installed:
    - name: dev-java/openjdk-bin
  portage_config.flags:
    - name: dev-java/openjdk-bin
    - use:
      - source
    - require_in:
      - pkg: jdk
