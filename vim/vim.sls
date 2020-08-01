vim:
  pkg.installed:
    - name: app-editors/vim

vimrc:
  file.managed:
    - name: {{ grains.user_home }}/.vimrc
    - source: salt://dotfiles/vim/vimrc
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - require:
      - pkg: vim
