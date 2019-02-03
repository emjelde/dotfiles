bash_logout:
  file.managed:
    - name: {{ grains.user_home }}/.bash_logout
    - source: salt://dotfiles/bash/bash_logout
    - user: {{ grains.user }}
    - group: {{ grains.user }}

bash_profile:
  file.managed:
    - name: {{ grains.user_home }}/.bash_profile
    - source: salt://dotfiles/bash/bash_profile
    - user: {{ grains.user }}
    - group: {{ grains.user }}

bashrc:
  file.managed:
    - name: {{ grains.user_home }}/.bashrc
    - source: salt://dotfiles/bash/bashrc
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - template: jinja

bashrc.d:
  file.recurse:
    - name: {{ grains.user_home }}/.bashrc.d
    - source: salt://dotfiles/bash/bashrc.d
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - require:
      - file: bashrc

bash-progs:
  pkg.installed:
    - name: app-shells/bash-completion
