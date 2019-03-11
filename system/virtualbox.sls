include:
  - ..x11

virtualbox-guest-additions:
  pkg.installed:
    - name: app-emulation/virtualbox-guest-additions
    - require:
      - pkg: x11
  portage_config.flags:
    - names:
      - media-libs/mesa:
        - use:
          - xa
      - x11-libs/libdrm:
        - use:
          - libkms
    - require_in:
      - pkg: x11
  service.running:
    - name: virtualbox-guest-additions
    - enable: true
    - require:
      - pkg: virtualbox-guest-additions
