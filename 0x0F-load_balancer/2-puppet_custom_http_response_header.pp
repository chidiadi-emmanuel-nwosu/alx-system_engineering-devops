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
  provider => shell,
  command  => @(END)
    echo '
    server {
        listen 80;
        listen [::]:80 default_server;
	root /var/www/html;
	index index.html index.htm index.nginx-debian.html;

	server_name _;

	add_header X-Served-By $HOSTNAME;

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


    }' | sudo tee /etc/nginx/sites-available/default
  END
}

# restart nginx
exec { 'restart_nginx':
  provider => shell,
  command  => 'sudo service nginx restart',
}
