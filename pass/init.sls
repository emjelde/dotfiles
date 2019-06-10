include:
  - ..bash
  - ..firefox

# Install password manager

pass:
  pkg.installed:
    - name: app-admin/pass
  file.accumulated:
    - name: .bashrc
    - filename: {{ grains.user_home }}/.bashrc
    - text: |
        ## Pass

        export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"
        export PASSWORD_STORE_SIGNING_KEY={{ grains.gpg_signing_key }}
    - require_in:
      - file: bashrc

# Allow access to password manager from Firefox

{% set passff_host_version = '1.2.0' %}
passff-host:
  pkg.installed:
    - name: www-plugins/passff-host
    - require:
      - pkg: firefox
      - pkg: pass
  portage_config.flags:
    - names:
      - =www-plugins/passff-host-{{ passff_host_version }}:
        - accept_keywords:
          - ~ARCH
      - www-plugins/passff-host:
        - use:
          - firefox
    - require_in:
      - pkg: passff-host
  file.managed:
    - name: /etc/portage/patches/www-plugins/passff-host/passff-host-env.patch
    - source: salt://dotfiles/pass/passff-host-env.patch
    - template: jinja
    - defaults:
        PASSWORD_STORE_DIR: {{ grains.xdg_data_home }}/pass
        PASSWORD_STORE_SIGNING_KEY: {{ grains.gpg_signing_key }}
        version: {{ passff_host_version }}
    - makedirs: true
    - require_in:
      - pkg: passff-host
