linux-headers:
  pkg.installed:
    - name: sys-kernel/linux-headers
  portage_config.flags:
    - name: "=sys-kernel/linux-headers-4.20"
    - accept_keywords:
      - ~ARCH
    - require:
      - pkg: linux-headers

gentoo-sources:
  pkg.installed:
    - name: sys-kernel/gentoo-sources
  portage_config.flags:
    - name: "=sys-kernel/gentoo-sources-4.20.0"
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: gentoo-sources
  file.recurse:
    - name: /etc/portage/patches/sys-kernel/gentoo-sources
    - source: salt://gentoo/patches/sys-kernel/gentoo-sources
    - require_in:
      - pkg: gentoo-sources
