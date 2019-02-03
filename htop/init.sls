htop:
  pkg.installed:
    - name: sys-process/htop
  file.managed:
    - name: {{ grains.xdg_config_home }}/htop/htoprc
    - source: salt://dotfiles/htop/htoprc
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - makedirs: true
    - require:
      - pkg: htop
