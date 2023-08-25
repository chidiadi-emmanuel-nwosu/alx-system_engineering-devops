# manifest that kills a process named killmenow
exec { 'killmenow_process':
  command  => 'pkill killmenow',
  onlyif   => 'pgrep killmenow',
  provider => 'shell'
}
