x11:
  pkg.installed:
    - name: x11-base/xorg-x11
  portage_config.flags:
    - name: x11-base/xorg-server
    - require_in:
      - pkg: x11

x11-progs:
  pkg.installed:
    - names:
      - x11-misc/xsel
    - require:
      - pkg: x11

# TODO SLiM is abandoned.
# Replace with another display manager (maybe LightDM or SDDM)
# https://wiki.gentoo.org/wiki/Display_manager
x-dm:
  pkg.installed:
    - name: x11-misc/slim
    - require:
      - pkg: x11
  file.line:
    - name: /etc/conf.d/xdm
    - content: DISPLAYMANAGER="slim"
    - match: DISPLAYMANAGER="xdm"
    - mode: replace
    - require:
      - pkg: x-dm
  service.running:
    - name: xdm
    - enable: true
    - require:
      - pkg: x-dm

# TODO look into using .Xresources instead
# https://superuser.com/questions/243914/xresources-or-xdefaults
x-defaults:
  file.managed:
    - name: {{ grains.user_home }}/.Xdefaults
    - source: salt://dotfiles/x11/Xdefaults
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - template: jinja
    - require:
      - pkg: x11

x-lock:
  pkg.installed:
    - name: x11-misc/xlockmore
  file.accumulated:
    - name: .Xdefaults
    - filename: {{ grains.user_home }}/.Xdefaults
    - text: |
        XLock.dpmsoff: 600
        XLock.font: -*-helvetica-medium-r-*-*-20-*-*-*-*-*-*
        XLock.mode: tetris
        XLock.usefirst: true
    - require:
      - pkg: x-lock
    - require_in:
      - file: x-defaults

x-defaults-colors:
  file.accumulated:
    - name: .Xdefaults
    - filename: {{ grains.user_home }}/.Xdefaults
    - text: |
        *color4:  #3465A4
        *color12: #6495ed
    - require_in:
      - file: x-defaults

x-modmap:
  file.managed:
    - name: {{ grains.user_home }}/.Xmodmap
    - source: salt://dotfiles/x11/Xmodmap
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - require:
      - pkg: x11
