salt:
  portage_config.flags:
    - names:
      # Salt USE flags are managed here as well as in salt/01-install.
      # It is probably best to keep them in sync.
      - app-admin/salt:
        - use:
          - gnupg
          - portage
          - vim-syntax
