# fixed the amount of traffic for an Nginx server.

exec { 'nginx-fix':
  provider => 'shell',
  command  => 'sed -i "s/15/4096/" /etc/default/nginx',
}

exec { 'nginx-restart':
  provider => 'shell',
  command  => 'sudo service nginx restart',
}
