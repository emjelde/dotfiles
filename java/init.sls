# TODO oracle-jdk is fetch restricted and must be manually downloaded
jdk:
  pkg.installed:
    - name: dev-java/oracle-jdk-bin
  portage_config.flags:
    - name: dev-java/oracle-jdk-bin
    - license:
      - Oracle-BCLA-JavaSE
    - use:
      - source
    - require_in:
      - pkg: jdk
