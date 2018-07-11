nitrokey-app:
  pkg.installed:
    - name: app-crypt/nitrokey-app
  portage_config.flags:
    - name: app-crypt/nitrokey-app
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: nitrokey-app

cppcodec-keywords:
  portage_config.flags:
    - name: =dev-libs/cppcodec-0.2
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: nitrokey-app

libnitrokey-keywords:
  portage_config.flags:
    - name: =app-crypt/libnitrokey-3.3
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: nitrokey-app
