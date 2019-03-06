yubikey:
  pkg.installed:
    - name: app-crypt/yubikey-manager

nitrokey:
  pkg.installed:
    - name: app-crypt/nitrokey-app
  portage_config.flags:
    - names:
      - =app-crypt/libnitrokey-3.3
      - =app-crypt/nitrokey-app-1.3.1
      - =dev-libs/cppcodec-0.2
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: nitrokey
