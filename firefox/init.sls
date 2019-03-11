firefox:
  pkg.installed:
    - name: www-client/firefox

firefox-keywords:
  portage_config.flags:
    - names:
      - =dev-lang/rust-1.32.0
      - =dev-libs/nss-3.42.1
      - =dev-util/cbindgen-0.7.1
      - =media-libs/libvpx-1.7.0
      - =media-libs/libwebp-1.0.2
      - =virtual/cargo-1.32.0
      - =virtual/rust-1.32.0
      - =www-client/firefox-65.0.2
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: firefox

firefox-useflags:
  portage_config.flags:
    - names:
      - dev-db/sqlite:
        - use:
          - secure-delete
      - dev-lang/python:
        - use:
          - sqlite
      - media-libs/libvpx:
        - use:
          - postproc
    - require_in:
      - pkg: firefox

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
