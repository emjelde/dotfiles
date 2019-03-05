firefox:
  pkg.installed:
    - name: www-client/firefox
  portage_config.flags:
    - name: =www-client/firefox-65.0.2
    - accept_keywords:
      - ~ARCH
    - require_in:
      - pkg: firefox

{% for (category, package, operator, version) in
  ('dev-lang',   'rust',     '=', '1.32.0'),
  ('dev-libs',   'nss',      '=', '3.42.1'),
  ('dev-util',   'cbindgen', '=', '0.7.1' ),
  ('media-libs', 'libvpx',   '=', '1.7.0' ),
  ('media-libs', 'libwebp',  '=', '1.0.2' ),
  ('virtual',    'cargo',    '=', '1.32.0'),
  ('virtual',    'rust',     '=', '1.32.0')
%}
{{ category }}-{{ package }}-flags:
  portage_config.flags:
    - name: {{ operator }}{{ category }}/{{ package }}-{{ version }}
    - accept_keywords:
      - ~ARCH
    {% if package == 'libvpx' %}
    - use:
      - postproc
    {% endif %}
    - require_in:
      - pkg: firefox
{% endfor %}

python-flags:
  portage_config.flags:
    - name: dev-lang/python
    - use:
      - sqlite
    - require_in:
      - pkg: firefox

sqlite-flags:
  portage_config.flags:
    - name: dev-db/sqlite
    - use:
      - secure-delete
    - require_in:
      - pkg: firefox

adobe-flash:
  pkg.installed:
    - name: www-plugins/adobe-flash
    - require:
      - pkg: firefox
  portage_config.flags:
    - name: www-plugins/adobe-flash
    - license:
      - AdobeFlash-11.x
    - require_in:
      - pkg: adobe-flash
