include:
  - ..x11

urxvt:
  pkg.installed:
    - name: x11-terms/rxvt-unicode
    - require:
      - portage_config: urxvt
      - file: .Xdefaults
  portage_config.flags:
    - name: x11-terms/rxvt-unicode
    - use:
      - 256-color
      - fading-colors
      - font-styles
      - iso14755
      - pixbuf
      - unicode3
      - xft
  file.accumulated:
    - name: .Xdefaults
    - filename: {{ grains.user_home }}/.Xdefaults
    - text: |
        URxvt*background: #000000
        URxvt*font: xft:Deja Vu Sans Mono:pixelsize=12
        URxvt*foreground: #FFFFFF
        URxvt*internalBorder: 0
        URxvt*jumpScroll: true
        {# Use tmux for scrollback buffer -#}
        URxvt*saveLines: 0
        URxvt*shading: 8
        URxvt*transparent: true
        URxvt*visualBell: false
    - require_in:
      - file: x-defaults
