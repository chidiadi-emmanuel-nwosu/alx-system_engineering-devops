# manifest that kills a process named killmenow
exec { 'killmenow':
  command  => 'pkill -x -f killmenow',
  onlyif   => 'pgrep -x -f killmenow',
  provider => 'shell'
}
