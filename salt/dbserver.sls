
#add-mysql-repo:
#  pkgrepo.managed:
#    - humanname: mysql-community
#    - baseurl: http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
#    - gpgcheck: 0
#    - require_in:
#      - pkg: mysqld
      
      
include:
  - mysql
