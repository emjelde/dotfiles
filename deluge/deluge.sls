deluge:
  pkg.installed:
    - name: net-p2p/deluge
  portage_config.flags:
    - names:
      - dev-libs/boost:
        - use:
          - python
      - net-libs/libtorrent-rasterbar:
        - use:
          - python
      - net-p2p/deluge:
        - use:
          - qtk
    - require:
      - eselect: profile
    - require_in:
      - pkg: deluge
