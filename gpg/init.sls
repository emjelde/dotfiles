include:
  - ..bash

gpg:
  pkg.installed:
    - name: app-crypt/gnupg

gpg-homedir:
  file.directory:
    - name: {{ grains.homedir }}/.gnupg
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - mode: 700

gpg-variables:
  eselect.set:
    - name: pinentry
    - target: pinentry-curses
  file.accumulated:
    - name: .bashrc
    - filename: {{ grains.homedir }}/.bashrc
    - text: |
        ## GPG

        # Set tty for curses based pinentry
        export GPG_TTY=$(tty)

        # Use curses pinentry for SSH logins
        if [[ -n "$SSH_CONNECTION" ]]; then
          export PINENTRY_USER_DATA="USE_CURSES=1"
        fi
    - require_in:
      - file: bashrc

gpg.conf:
  file.managed:
    - name: {{ grains.homedir }}/.gnupg/gpg.conf
    - source: salt://dotfiles/gpg/gpg.conf
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - require:
      - file: gpg-homedir

gpg-agent.conf:
  file.managed:
    - name: {{ grains.homedir }}/.gnupg/gpg-agent.conf
    - source: salt://dotfiles/gpg/gpg-agent.conf
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - require:
      - file: gpg-homedir

sshcontrol:
  file.managed:
    - name: {{ grains.homedir }}/.gnupg/sshcontrol
    - source: salt://dotfiles/gpg/sshcontrol
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - require:
      - file: gpg-homedir
