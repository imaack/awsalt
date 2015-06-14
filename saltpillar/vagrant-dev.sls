run-as-group: vagrant
run-as-user: vagrant
app-location: /srv/webapp



mysql:
  server:
    root_user: 'root'
    root_password: 'rootpass'

  # Install MySQL headers
  dev:
    # Install dev package - defaults to False
    install: True