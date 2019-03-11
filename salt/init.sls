salt:
  portage_config.flags:
    - names:
      # Salt keywords are managed here as well as in salt/01-install.
      # It is probably best to keep them in sync.
      - <app-admin/salt-2018.3.0:
        - accept_keywords:
          - ~ARCH
      - app-admin/salt:
        - use:
          - gnupg
          - portage
          - vim-syntax
