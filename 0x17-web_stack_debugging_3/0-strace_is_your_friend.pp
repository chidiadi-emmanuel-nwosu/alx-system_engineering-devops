# puppet file to fix apache server
exec { 'fix-apache-server':
  provider => 'shell',
  command  => 'sed -i s/phpp/php/g /var/www/html/wp-settings.php',
}
