git:
  pkg.installed:
    - name: dev-vcs/git
  portage_config.flags:
    - name: dev-vcs/git
    - use:
      - doc
    - require_in:
      - pkg: git

git-attributes:
  file.managed:
    - name: {{ grains.homedir }}/.config/git/attributes
    - source: salt://dotfiles/git/attributes
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - makedirs: true
    - require:
      - pkg: git

git-config:
  file.managed:
    - name: {{ grains.homedir }}/.config/git/config
    - source: salt://dotfiles/git/config
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - require:
      - pkg: git
