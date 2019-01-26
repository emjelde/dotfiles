salt:
  pkg.installed:
    - name: app-admin/salt
  portage_config.flags:
    - name: <app-admin/salt-2018.3.0
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: salt

salt-flags:
  portage_config.flags:
    - name: app-admin/salt
    - use:
      - gnupg
      - portage
      - vim-syntax
    - require_in:
      - pkg: salt

pycryptodome-keywords:
  portage_config.flags:
    - name: =dev-python/pycryptodome-3.4.7
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: salt

python-gnupg-keywords:
  portage_config.flags:
    - name: =dev-python/python-gnupg-0.4.3
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: salt
