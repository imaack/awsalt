
add-passenger-repo:
  pkgrepo.managed:
    - humanname: Passenger
    - baseurl: https://oss-binaries.phusionpassenger.com/yum/passenger/el/$releasever/$basearch
    - gpgcheck: 0
    - require_in:
      - pkg: nginx-and-passenger-installed

passenger-deps:
  pkg.installed:
    - pkgs:
      - epel-release
      - pygpgme
      - curl
      - nodejs

nginx-and-passenger-installed:
  pkg.installed:
    - pkgs:
      - nginx
      - passenger
    - require:
      - pkg: passenger-deps


/etc/nginx/nginx.conf:
  file.managed:
    - template: jinja
    - source:
      - salt://config/nginx.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx-and-passenger-installed

/etc/nginx/conf.d/passenger.conf:
  file.managed:
    - template: jinja
    - source:
      - salt://config/passenger.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx-and-passenger-installed

    
webapp-directory-exists:
  file.directory:
    - name: {{ pillar['app-location'] }}
    - makedirs: True
    - user: {{ pillar['run-as-user'] }}
    - group: {{ pillar['run-as-group'] }}

rails:
  gem.installed:
    - user: {{ pillar['run-as-user'] }}
