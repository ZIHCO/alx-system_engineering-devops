# This manifest kills a process named killmenow

exec { 'kill-killmenow':
  command => '/bin/pkill killmenow'
}
