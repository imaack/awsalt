#gpg-import-passenger-key:
#    cmd.run:
#        - user: {{ pillar['run-as-user'] }}
#        - require:
#            - user: {{ pillar['run-as-user'] }}
#        - name: sudo gpg --keyserver https://packagecloud.io/gpg.key --recv-keys 418a7f2fb0e1e6e7eabf6fe8c2e73424d59097ab
#        - unless: sudo gpg --fingerprint |fgrep 'Key fingerprint = 418A 7F2F B0E1 E6E7 EABF  6FE8 C2E7 3424 D590 97AB'

add-passenger-repo:
  pkgrepo.managed:
    - humanname: Passenger
    - baseurl: https://oss-binaries.phusionpassenger.com/yum/passenger/el/$releasever/$basearch
    - gpgcheck: 0
    #- gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
    - require_in:
      - pkg: nginx-and-passenger-installed
    
    



#add-passenger-repo:
#  cmd.run:
#    - user: {{ pillar['run-as-user'] }}
#    - require:
#      - user: {{ pillar['run-as-user'] }}
#      - cmd: gpg-import-passenger-key
#    - name: "sudo curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo && sudo chown root: /etc/yum.repos.d/passenger.repo && sudo chmod 600 /etc/yum.repos.d/passenger.repo"
#    - unless: ls /etc/yum.repos.d/passenger.repo
#
#

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
      #- cmd: add-passenger-repo
