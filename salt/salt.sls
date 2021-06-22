include:
  - ..portage

salt:
  portage_config.flags:
    - names:
      # Salt USE flags are managed here as well as in salt/salt-apply.
      # It is probably best to keep them in sync.
      - ~app-admin/salt-3003:
        - accept_keywords:
          - ~ARCH
      - app-admin/salt:
        - use:
          - gnupg
          - portage
          - vim-syntax
    - require:
      - eselect: profile
