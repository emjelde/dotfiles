htop:
  pkg.installed:
    - name: sys-process/htop
  file.managed:
    - name: {{ grains.homedir }}/.config/htop/htoprc
    - source: salt://dotfiles/htop/htoprc
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - makedirs: true
    - require:
      - pkg: htop
