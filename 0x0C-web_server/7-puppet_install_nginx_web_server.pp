# install and configure nginx using puppet

# update the os packages
exec { 'install_nginx':
  provider => shell,
  command  => 'sudo apt -y update; sudo apt install -y nginx',
}

# create return string on query
exec { 'create_return_string':
  provider => shell,
  command  => 'echo "Hello World!" | sudo tee /var/www/html/index.nginx-debian.html',
}

# create the nginx configuration
exec { 'configure_server':
}

# restart nginx
exec { 'restart_nginx':
  provider => shell,
  command  => 'sudo service nginx restart',
}
