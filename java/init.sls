# TODO oracle-jdk is fetch restricted and must be manually downloaded
jdk:
  pkg.installed:
    - name: dev-java/oracle-jdk-bin

oracle-jdk-bin-flags:
  portage_config.flags:
    - name: dev-java/oracle-jdk-bin
    - use:
      - 'source'
    - require_in:
      - pkg: jdk

oracle-jdk-bin-license:
  portage_config.flags:
    - name: dev-java/oracle-jdk-bin
    - license:
      - Oracle-BCLA-JavaSE
    - require_in:
      - pkg: jdk
