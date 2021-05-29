python-useflags:
  portage_config.flags:
    - name: dev-lang/python
    - use:
      - sqlite
    - require:
      - eselect: profile
