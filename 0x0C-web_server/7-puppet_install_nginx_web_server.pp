# install and configure nginx using puppet

# update the os packages
class { 'apt':
  update_cache => True,
}

# install nginx
package { 'nginx':
  ensure => installed,
}

# create the nginx configuration
exec { 'configure_server':
  command => '
printf %s "server {
    listen 80;
    listen [::]:80 default_server;
    root   /etc/nginx/html;
    index  index.html index.htm;

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }

    error_page 404 /404.html;
    location /404 {
      root /etc/nginx/html;
      internal;      
    }
}" | sudo tee /etc/nginx/sites-available/default',

  require => File['/etc/nginx/sites-available/default'],
  notify  => Service['nginx'],
}

exec { 'create_index_html':
  command => 'echo "Hello World!" | sudo tee /var/www/html/index.nginx-debian.html',
  creates => '/var/www/html/index.nginx-debian.html',
  notify  => Service['nginx'],
}

exec { 'create_404_html':
  command => 'echo "Ceci n\'est pas une page" | sudo tee /etc/nginx/html/404.html',
  creates => '/etc/nginx/html/404.html',
  require => File['/etc/nginx/sites-available/default'],
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx']
}
