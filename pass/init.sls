include:
  - ..bash
  - ..firefox

# Install password manager

{% set signing_key = '23963D530C8A9B2DBFC61FCA92BEB0268C8FE597' %}
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

        export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"
        export PASSWORD_STORE_SIGNING_KEY={{ signing_key }}
    - require_in:
      - file: bashrc

# Allow access to password manager from Firefox

{% set passff_host_version = '1.0.2' %}
passff-host:
  pkg.installed:
    - name: www-plugins/passff-host
    - require:
      - pkg: pass
  portage_config.flags:
    - name: =www-plugins/passff-host-{{ passff_host_version }}
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: passff-host
  file.managed:
    - name: /etc/portage/patches/www-plugins/passff-host/passff-host-env.patch
    - source: salt://dotfiles/pass/passff-host-env.patch
    - template: jinja
    - defaults:
        # TODO resolve ${XDG_DATA_HOME}/pass instead
        PASSWORD_STORE_DIR: {{ grains.homedir }}/.local/share/pass
        PASSWORD_STORE_SIGNING_KEY: {{ signing_key }}
        version: {{ passff_host_version }}
    - makedirs: true
    - require_in:
      - pkg: passff-host

passff-host-flags:
  portage_config.flags:
    - name: www-plugins/passff-host
    - use:
      - firefox
    - require:
      - pkg: firefox
    - require_in:
      - pkg: passff-host
