# make changes to our configuration file
exec { 'ssh_config':
  command => 'echo "IdentityFile ~/.ssh/school\n    PasswordAuthentication no" >> /etc/ssh/ssh_config',
  path    => '/bin:/usr/bin'
}
