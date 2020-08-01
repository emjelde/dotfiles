jdk:
  pkg.installed:
    - name: dev-java/openjdk-bin
    - require:
      - portage_config: jdk
  portage_config.flags:
    - name: dev-java/openjdk-bin
    - use:
      - source
