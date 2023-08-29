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

# make a html directory
exec { 'mkdir_directoy':
  provider => shell,
  command  => 'sudo mkdir /etc/nginx/html/',
}

# make a html directory
exec { 'create_404_html':
  provider => shell,
  command  => 'echo "Ceci n\'est pas une page" | sudo tee /etc/nginx/html/404.html',
}

# create the nginx configuration
exec { 'configure_server':
  provider => shell,
  command  => '
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
  provider => shell,
  command  => 'sudo service nginx restart',
}
