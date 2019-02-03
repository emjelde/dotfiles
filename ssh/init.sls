include:
  - ..bash

ssh:
  file.managed:
    - name: {{ grains.user_home }}/.ssh/config
    - source: salt://dotfiles/ssh/config
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - makedirs: true
    - template: jinja

ssh-variables:
  file.accumulated:
    - name: .bashrc
    - filename: {{ grains.user_home }}/.bashrc
    - text: |
        ## SSH

        # Use gpg-agent for SSH authentication
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    - require_in:
      - file: bashrc

sshfs:
  pkg.installed:
    - name: net-fs/sshfs
    - require_in:
      - file: fuse-conf

fuse-conf:
  file.line:
    - name: /etc/fuse.conf
    - content: user_allow_other
    - match: '#user_allow_other'
    - mode: replace

{% macro ssh(host, fingerprint, identityfile, username) %}
ssh-{{ host }}:
  ssh_known_hosts.present:
    - name: {{ host }}
    - user: {{ grains.user }}
    - fingerprint: {{ fingerprint }}
    - fingerprint_hash_type: md5
    - enc: ssh-rsa
    - hash_known_hosts: false
    - require:
      - file: ssh

ssh-{{ host }}-config:
  file.accumulated:
    - name: .ssh/config
    - filename: {{ grains.user_home }}/.ssh/config
    - text: |
        Host {{ host }}
        HostName {{ host }}
        Port 22
        User {{ username }}
        IdentityFile ~/.ssh/{{ identityfile }}
    - require_in:
      - file: ssh
      - ssh_known_hosts: ssh-{{ host }}

ssh-{{ host }}-identity:
  file.managed:
    - name: {{ grains.user_home }}/.ssh/{{ identityfile }}
    - contents_pillar: .ssh/{{ identityfile }}
    - user: {{ grains.user }}
    - group: {{ grains.user }}
    - mode: 600
    - makedirs: true
    - require_in:
      - file: ssh-{{ host }}-config
{% endmacro %}

{{ ssh(host='bitbucket.org',
       fingerprint='97:8c:1b:f2:6f:14:6b:5c:3b:ec:aa:46:46:74:7c:40',
       identityfile='bitbucket/id_rsa',
       username='emjelde')
}}
{{ ssh(host='github.com',
       fingerprint='16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48',
       identityfile='github/id_rsa',
       username='emjelde')
}}
{{ ssh(host='vs-ssh.visualstudio.com',
       fingerprint='97:70:33:82:fd:29:3a:73:39:af:6a:07:ad:f8:80:49',
       identityfile='visualstudio/id_rsa',
       username='emjelde')
}}
