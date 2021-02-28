minecraft-server:
  pkg.installed:
    - name: games-server/minecraft-server
    - require:
      - portage_config: minecraft-server
  portage_config.flags:
    - name: games-server/minecraft-server
    - license:
      - Mojang

minecraft-server-conf:
  file.managed:
    - name: /etc/conf.d/minecraft-server
    - source: salt://dotfiles/minecraft/server.conf
    - require:
      - pkg: minecraft-server

minecraft-server-properties:
  file.managed:
    - name: /var/lib/minecraft-server/main/server.properties
    - source: salt://dotfiles/minecraft/server.properties
    - user: minecraft
    - group: minecraft
    - makedirs: true
    - require:
      - pkg: minecraft-server
