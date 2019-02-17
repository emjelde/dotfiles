include:
  - ..portage

deluge:
  pkg.installed:
    - name: net-p2p/deluge
    - require:
      - portage_config: boost-flags
  portage_config.flags:
    - name: net-p2p/deluge
    - use:
      - qtk
    - require_in:
      - pkg: deluge

libtorrent-rasterbar-flags:
  portage_config.flags:
    - name: net-libs/libtorrent-rasterbar
    - use:
      - python
    - require_in:
      - pkg: deluge
