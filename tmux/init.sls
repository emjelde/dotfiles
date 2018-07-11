tmux:
  pkg.installed:
    - name: app-misc/tmux
  file.managed:
    - name: {{ grains.homedir }}/.tmux.conf
    - source: salt://dotfiles/tmux/tmux.conf
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - require:
      - pkg: app-misc/tmux
