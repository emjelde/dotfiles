include:
  - ..bash

pass:
  pkg.installed:
    - name: app-admin/pass
  portage_config.flags:
    - name: app-admin/pass
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: pass
  file.accumulated:
    - name: .bashrc
    - filename: {{ grains.homedir }}/.bashrc
    - text: |
        ## Pass

        export PASSWORD_STORE_SIGNING_KEY=23963D530C8A9B2DBFC61FCA92BEB0268C8FE597
    - require_in:
      - file: bashrc
