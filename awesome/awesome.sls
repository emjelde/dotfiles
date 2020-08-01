include:
  - ..git

awesome:
  pkg.installed:
    - name: x11-wm/awesome
  portage_config.flags:
    # TODO update to the latest awesome
    - name: '>=x11-wm/awesome-4'
    - mask: true
    - require_in:
      - pkg: awesome
  file.managed:
    - name: /etc/env.d/90xsession
    - contents:
      - XSESSION="awesome"
    - require:
      - pkg: awesome

# TODO clean up rc.lua
awesome-config:
  file.managed:
    - name: {{ grains.xdg_config_home }}/awesome/rc.lua
    - source: salt://dotfiles/awesome/rc.lua
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - makedirs: true
    - require:
      - pkg: awesome

awesome-startup:
  file.managed:
    - name: {{ grains.xdg_config_home }}/awesome/startup
    - source: salt://dotfiles/awesome/startup
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - mode: 770
    - makedirs: true
    - require_in:
      - file: awesome-config

awesome-themes-zenburn:
  cmd.run:
    - name: >
        mkdir --parents {{ grains.xdg_config_home }}/awesome/themes &&
        cp --recursive /usr/share/awesome/themes/zenburn {{ grains.xdg_config_home }}/awesome/themes/
    - onchanges:
      - pkg: awesome
  file.directory:
    - name: {{ grains.xdg_config_home }}/awesome/themes/zenburn
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - recurse:
      - user
      - group
      - mode
    - require:
      - cmd: awesome-themes-zenburn

awesome-themes-custom:
  file.patch:
    - name: {{ grains.xdg_config_home }}/awesome/themes/zenburn/theme.lua
    - source: salt://dotfiles/awesome/theme.patch
    - hash: 25da5f8d57c7fe54d7269d75e67c1d22d0c08e75
    - onchanges:
      - file: awesome-themes-zenburn

awesome-wallpapers:
  file.recurse:
    - name: {{ grains.xdg_config_home }}/awesome/wallpapers
    - source: salt://dotfiles/awesome/wallpapers
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - require_in:
      - file: awesome-themes-custom

awesome-alttab:
  git.detached:
    - name: https://github.com/jorenheit/awesome_alttab
    - target: {{ grains.xdg_config_home }}/awesome/alttab
    - user: {{ grains.user }}
    - rev: 40d70b7537e86697ec4918b8a3f84ecdc63feede
    - require_in:
      - file: awesome-config
    - require:
      - pkg: git

awesome-lain:
  git.detached:
    - name: https://github.com/copycat-killer/lain.git
    - target: {{ grains.xdg_config_home }}/awesome/lain
    - user: {{ grains.user }}
    - rev: 301faf5370d045e94c9c344acb0fdac84a2f25a6
    - require_in:
      - file: awesome-config
    - require:
      - pkg: git

# TODO scratch seems to be unmaintained,
# look into a replacement maybe lain Quake
awesome-scratch:
  git.detached:
    - name: https://github.com/proteansec/awesome-scratch.git
    - target: {{ grains.xdg_config_home }}/awesome/scratch
    - user: {{ grains.user }}
    - rev: b386269d61cb8acb3d26fe37aed37eaae645a04f
    - require_in:
      - file: awesome-config
    - require:
      - pkg: git

awesome-vicious:
  git.detached:
    - name: https://github.com/Mic92/vicious.git
    - target: {{ grains.xdg_config_home }}/awesome/vicious
    - user: {{ grains.user }}
    - rev: a13ddc08921e3da1f8691be9139abeccfa3f0bff
    - require_in:
      - file: awesome-config
    - require:
      - pkg: git
