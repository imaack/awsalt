
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

/etc/nginx/conf.d/passenger.conf:
  file.managed:
    - template: jinja
    - source:
      - salt://config/passenger.conf
    - user: root
    - group: root
    - mode: 644
    
    
/srv/webapp/public:
  file.managed:
    - user: {{ pillar['run-as-user'] }}
    - group: {{ pillar['run-as-group'] }}


