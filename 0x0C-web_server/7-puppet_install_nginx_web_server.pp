# install and configure nginx using puppet

# update the os packages
exec { 'update':
  command => 'sudo apt -y update',
}

# install nginx
exec { 'install_nginx':
  command => 'sudo apt install -y nginx',
}

# create return string on query
exec { 'create_return_string':
  command => 'echo "Hello World!" | sudo tee /var/www/html/index.nginx-debian.html',
}

# make a html directory
exec { 'mkdir_directoy':
  command => 'sudo mkdir /etc/nginx/html/',
}

# make a html directory
exec { 'create_404_html':
  command => 'echo "Ceci n\'est pas une page" | sudo tee /etc/nginx/html/404.html',
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
}

# restart nginx
exec { 'restart_nginx':
  command => 'sudo service nginx restart',
}
