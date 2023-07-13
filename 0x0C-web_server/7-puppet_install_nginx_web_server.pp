# Puppet manifest containing commands to automatically configure an
# Ubuntu machine to respect above requirements:
# ngnix shouldbe installed and listen on port 80
# When querying Nginx at its root / with a GET request (requesting a page)
# using curl, it must return a page that contains the string Hello World!
# The redirection must be a “301 Moved Permanently”.
include stdlib

exec { 'update apt':
  command => '/usr/bin/apt-get update'
}

exec { 'nginx restart':
  command => '/usr/sbin/service restart nginx',
  require => Package['nginx']
}

package { 'nginx':
  ensure  => installed,
  require => Exec['update apt']
}

file { '/var/www/html/index.html':
  ensure  => present,
  mode    => '0744',
  content => 'Hello World!',
  owner   => 'root',
  group   => 'root'
}

file_line { 'redirect_me':
  ensure   => present,
  path     => '/etc/nginx/sites-available/default',
  after    => 'server\ _;',
  line     => "# location /redirect_me {",
  notify   => Exec['nginx restart'],
  multiple => true,
  require  => File['/var/www/html/index.html']
}

exec { 'insert_block':
  command => 'sed -i "s|# location /redirct_me {|location /redirect_me {\n\t\treturn 301 https://twitter.com/jamesmatics;\n\t}" /etc/nginx/sites-available/default',
  path    => '/usr/bin:/bin'
}

exec { 'nginx restart':
  command => '/usr/sbin/service restart nginx',
  require => Package['nginx']
}
