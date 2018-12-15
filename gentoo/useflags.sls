asciidoc-flags:
  portage_config.flags:
    - name: asciidoc
    - use:
      - 'python_single_target_python2_7'

boost-flags:
  portage_config.flags:
    - name: dev-libs/boost
    - use:
      - 'icu'
      - 'python'

gd-flags:
  portage_config.flags:
    - name: media-libs/gd
    - use:
      - 'fontconfig'

# ncurses and gpm depend on each other and portage doesn't know how to handle
# this yet :(
#
# https://bugs.gentoo.org/602690
# https://forums.gentoo.org/viewtopic-t-1062884-start-0.html
ncurses-flags:
  portage_config.flags:
    - name: sys-libs/ncurses
    - use:
      - '-gpm'

pinentry-flags:
  portage_config.flags:
    - name: app-crypt/pinentry
    - use:
      - 'gnome-keyring'

python-flags:
  portage_config.flags:
    - name: dev-lang/python
    - use:
      - 'sqlite'

sudo-flags:
  portage_config.flags:
    - name: app-admin/sudo
    - use:
      - '-sendmail'

util-linux-flags:
  portage_config.flags:
    - name: sys-apps/util-linux
    - use:
      - 'tty-helpers'
