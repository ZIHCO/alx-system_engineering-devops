# Create a manifest that kills a process named killmenow

exec { 'pkill':
  command => '/bin/pkill killmenow',
}
