firefox:
  pkg.installed:
    - name: www-client/firefox
  portage_config.flags:
    - name: www-client/firefox
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: firefox

cbindgen-keywords:
  portage_config.flags:
    - name: =dev-util/cbindgen-0.6.6
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: firefox

adobe-flash:
  pkg.installed:
    - name: www-plugins/adobe-flash
  portage_config.flags:
    - name: www-plugins/adobe-flash
    - license:
      - AdobeFlash-11.x
    - require_in:
      - pkg: adobe-flash
    - require:
      - pkg: firefox
