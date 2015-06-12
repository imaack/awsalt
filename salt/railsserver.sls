
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
