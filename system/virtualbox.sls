include:
  - ..x11

virtualbox-guest-additions:
  pkg.installed:
    - name: app-emulation/virtualbox-guest-additions
    - require:
      - pkg: x11
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
      - pkg: x11

mesa-flags:
  portage_config.flags:
    - name: media-libs/mesa
    - use:
      - xa
    - require_in:
      - pkg: x11
