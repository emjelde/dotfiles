media-fonts:
  pkg.installed:
    - names:
      - media-fonts/corefonts
      - media-fonts/dejavu
      - media-fonts/liberation-fonts
      - media-fonts/noto
      - media-fonts/noto-cjk
      - media-fonts/roboto
      - media-fonts/source-pro

# Fonts should really be configured through eselect but salt.states.eselect
# only supports the 'set' action and we need an 'enable' action.
{% for conf in
  '20-unhint-small-dejavu-sans.conf',
  '20-unhint-small-dejavu-sans-mono.conf',
  '20-unhint-small-dejavu-serif.conf',
  '57-dejavu-sans.conf',
  '57-dejavu-sans-mono.conf',
  '57-dejavu-serif.conf'
%}
media-fonts-dejavu-{{ loop.index }}:
  file.symlink:
    - name: /etc/fonts/conf.d/{{ conf }}
    - target: /etc/fonts/conf.avail/{{ conf }}
    - require:
      - pkg: media-fonts/dejavu
{% endfor %}
