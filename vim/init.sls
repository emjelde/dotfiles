vim:
  pkg.installed:
    - name: app-editors/vim

vimrc:
  file.managed:
    - name: {{ grains.homedir }}/.vimrc
    - source: salt://dotfiles/vim/vimrc
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - require:
      - pkg: vim
