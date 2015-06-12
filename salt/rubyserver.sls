run-as-user-present:
  group.present:
    - name: {{ pillar['run-as-user'] }}
  user.present:
    - name: {{ pillar['run-as-user'] }}
    - home: /home/{{ pillar['run-as-user'] }}
    - require:
      - group: {{ pillar['run-as-group'] }}

rvm-deps:
  pkg.installed:
    - pkgs:
      - patch
      - libyaml-devel
      - glibc-headers
      - autoconf
      - gcc-c++
      - glibc-devel
      - patch
      - readline-devel
      - zlib-devel
      - libffi-devel
      - openssl-devel
      - automake
      - libtool
      - bison
      - sqlite-devel

ruby-2.2.1:
  rvm.installed:
    - default: True
    - user: {{ pillar['run-as-user'] }}
    - require:
      - pkg: rvm-deps
      - user: {{ pillar['run-as-user'] }}
      - cmd: gpg-import-rvm-key


mygemset:
  rvm.gemset_present:
    - ruby: ruby-2.2.1
    - user: {{ pillar['run-as-user'] }}
    - require:
      - rvm: ruby-2.2.1
      
gpg-import-rvm-key:
    cmd.run:
        - user: {{ pillar['run-as-user'] }}
        - require:
            - user: {{ pillar['run-as-user'] }}
        - name: gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
        - unless: gpg --fingerprint |fgrep 'Key fingerprint = 409B 6B17 96C2 7546 2A17  0311 3804 BB82 D39D C0E3'
