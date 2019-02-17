salt:
  portage_config.flags:
    # Salt keywords are managed here as well as in salt/01-install.
    # It is probably best to keep them in sync.
    - name: <app-admin/salt-2018.3.0
    - accept_keywords:
      - ~ARCH

salt-flags:
  portage_config.flags:
    - name: app-admin/salt
    - use:
      - gnupg
      - portage
      - vim-syntax
