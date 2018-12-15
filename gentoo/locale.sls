system-locale-en_US.utf8:
  locale.system:
    - name: en_US.utf8
    - require:
      - locale: gen-locale-en_US.UTF-8

gen-locale-en_US-ISO-8859-1:
  locale.present:
    - name: en_US ISO-8859-1

gen-locale-en_US.UTF-8:
  locale.present:
    - name: en_US.UTF-8 UTF-8
