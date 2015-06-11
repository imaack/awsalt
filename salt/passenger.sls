# Install Passenger
#passenger-gem:
#  cmd.run:
#    - user: {{ pillar['run-as-user'] }}
#    - name: gem install passenger
#    - require:
#      - rvm: ruby-2.2.1

passenger-gem:
  gem.installed:
    - user: {{ pillar['run-as-user'] }}
    - name: passenger


passenger-deps:
  pkg.installed:
    - pkgs:
        - libcurl4-openssl-dev

# Install Passenger Nginx Module
passenger-nginx-module:
  cmd.run:
    - user: {{ pillar['run-as-user'] }}
    - name: export rvmsudo_secure_path=1 && rvmsudo passenger-install-nginx-module --auto # | fgrep 'failed'
    - unless: ls /opt/nginx/conf/nginx.conf
    - require:
      - gem: passenger-gem
      - pkg: passenger-deps
      - cmd: enable-swap


enable-swap:
  cmd.run:
    - name: sudo dd if=/dev/zero of=/swapfile bs=1024 count=256k && sudo mkswap /swapfile && sudo swapon /swapfile
    - unless: sudo swapon -s |fgrep '/swapfile'
    

nodejs-installed:
  pkg.installed:
    - pkgs:
      - nodejs
