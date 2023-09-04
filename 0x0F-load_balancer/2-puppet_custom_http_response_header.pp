# Install and configure Nginx using Puppet

# Update the OS packages
exec { 'update_packages':
  provider => shell,
  command  => 'sudo apt -y update',
}

# Install Nginx
package { 'nginx':
  ensure  => 'installed',
  require => Exec['update_packages'],
}

# Create a return string for queries
file { '/var/www/html/index.nginx-debian.html':
  ensure  => 'present',
  content => 'Hello World!',
  require => Package['nginx'],
}

# Create the error file
file { '/etc/nginx/html/404.html':
  ensure  => 'present',
  content => 'Ceci n\'est pas une page',
  require => Package['nginx'],
}

# Configure the Nginx server
file { '/etc/nginx/sites-available/default':
  ensure  => 'present',
  content => '
    server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        add_header X-Served-By "$::hostname";

        location / {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            try_files $uri $uri/ =404;
        }
        location /redirect_me {
            return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
        }

        error_page 404 /404.html;
        location /404 {
            root /etc/nginx/html;
            internal;      
        }
    }',
  require => File['/etc/nginx/html/404.html'],
}

# Restart Nginx
service { 'nginx':
  ensure    => 'running',
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}
