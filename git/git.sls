include:
  - ..bash
  - ..portage

git:
  pkg.installed:
    - name: dev-vcs/git
    - require:
      - portage_config: git
  portage_config.flags:
    - name: dev-vcs/git
    - use:
      - doc
    - require:
      - eselect: profile

git-attributes:
  file.managed:
    - name: {{ grains.xdg_config_home }}/git/attributes
    - source: salt://dotfiles/git/attributes
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - makedirs: true
    - require:
      - pkg: git

git-config:
  file.managed:
    - name: {{ grains.xdg_config_home }}/git/config
    - source: salt://dotfiles/git/config
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - makedirs: true
    - template: jinja
    - defaults:
        signingkey: {{ grains.gpg_signing_key }}
    - require:
      - pkg: git

git-prompt-bashrc.d:
  file.managed:
    - name: {{ grains.user_home }}/.bashrc.d/git-prompt
    - source: salt://dotfiles/git/git-prompt
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - makedirs: true
    - require:
      - pkg: git

git-prompt-bashrc:
  file.accumulated:
    - name: .bashrc.d
    - filename: {{ grains.user_home }}/.bashrc
    - text: source ~/.bashrc.d/git-prompt
    - require_in:
      - file: bashrc
    - require:
      - file: git-prompt-bashrc.d
