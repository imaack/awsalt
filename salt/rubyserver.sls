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
      - bash
      - coreutils
      - gzip
      - bzip2
      - gawk
      - sed
      - curl
      - git-core
      - subversion


mri-deps:
  pkg.installed:
    - pkgs:
      - build-essential
      - openssl
      - libreadline6
      - libreadline6-dev
      - curl
      - git-core
      - zlib1g
      - zlib1g-dev
      - libssl-dev
      - libyaml-dev
      - libsqlite3-0
      - libsqlite3-dev
      - sqlite3
      - libxml2-dev
      - libxslt1-dev
      - autoconf
      - libc6-dev
      - libncurses5-dev
      - automake
      - libtool
      - bison
      - subversion
      - ruby

jruby-deps:
  pkg.installed:
    - pkgs:
      - curl
      - g++
      - openjdk-6-jre-headless

ruby-2.2.1:
  rvm.installed:
    - default: True
    - user: {{ pillar['run-as-user'] }}
    - require:
      - pkg: rvm-deps
      - pkg: mri-deps
      - user: {{ pillar['run-as-user'] }}
      - cmd: gpg-import-rvm-key

#jruby:
#  rvm.installed:
#    - user: {{ pillar['run-as-user'] }}
#    - require:
#      - pkg: rvm-deps
#      - pkg: jruby-deps
#      - user: {{ pillar['run-as-user'] }}

#jgemset:
#  rvm.gemset_present:
#    - ruby: jruby
#    - user: {{ pillar['run-as-user'] }}
#    - require:
#      - rvm: jruby

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
