locale:
  locale.present:
    - names:
      - en_US ISO-8859-1
      - en_US.UTF-8 UTF-8

default-locale:
  locale.system:
    - name: en_US.utf8
    - require:
      - locale: en_US.UTF-8 UTF-8
