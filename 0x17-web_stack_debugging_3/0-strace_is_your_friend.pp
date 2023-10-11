exec { 'fix-wordpress-server':
  provider => 'shell',
  command  => 'sed -i s/phpp/php/g /var/www/html/wp-settings.php',
}
