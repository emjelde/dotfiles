firefox:
  pkg.installed:
    - name: www-client/firefox-bin

adobe-flash:
  pkg.installed:
    - name: www-plugins/adobe-flash
    - require:
      - pkg: firefox
  portage_config.flags:
    - name: www-plugins/adobe-flash
    - license:
      - AdobeFlash-11.x
    - require_in:
      - pkg: adobe-flash
