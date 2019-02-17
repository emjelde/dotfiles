virtualbox-guest-additions:
  pkg.installed:
    - name: app-emulation/virtualbox-guest-additions
  portage_config.flags:
    - name: app-emulation/virtualbox-guest-additions
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: virtualbox-guest-additions
  service.running:
    - name: virtualbox-guest-additions
    - enable: true
    - require:
      - pkg: virtualbox-guest-additions

libdrm-flags:
  portage_config.flags:
    - name: x11-libs/libdrm
    - use:
      - libkms
    - require_in:
      - pkg: virtualbox-guest-additions

mesa-flags:
  portage_config.flags:
    - name: media-libs/mesa
    - use:
      - xa
    - require_in:
      - pkg: virtualbox-guest-additions
