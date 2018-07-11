yubikey-manager:
  pkg.installed:
    - name: app-crypt/yubikey-manager
  portage_config.flags:
    - name: app-crypt/yubikey-manager
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: yubikey-manager

yubikey-personalization-gui:
  pkg.installed:
    - name: sys-auth/yubikey-personalization-gui
  portage_config.flags:
    - name: sys-auth/yubikey-personalization-gui
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: yubikey-personalization-gui

fido2-keywords:
  portage_config.flags:
    - name: =dev-python/fido2-0.4.0
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: yubikey-manager

pyscard-keywords:
  portage_config.flags:
    - name: =dev-python/pyscard-1.9.5
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: yubikey-manager

pyusb-keywords:
  portage_config.flags:
    - name: =dev-python/pyusb-1.0.2
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: yubikey-manager

ykpers-keywords:
  portage_config.flags:
    - name: sys-auth/ykpers
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: yubikey-manager
      - pkg: yubikey-personalization-gui
