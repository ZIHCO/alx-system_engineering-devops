# Puppet manifest containing commands to automatically configure an
# Ubuntu machine to respect above requirements:
# ngnix shouldbe installed and listen on port 80
# When querying Nginx at its root / with a GET request (requesting a page)
# using curl, it must return a page that contains the string Hello World!
# The redirection must be a “301 Moved Permanently”.

exec { 'update packages':
  command => '/usr/bin/apt-get update'
}

exec { 'nginx restart':
  command => '/usr/sbin/service nginx restart',
  require => Package['nginx']
}

package { 'nginx':
  ensure  => installed,
  require => Exec['update packages']
}

file { '/var/www/html/index.html':
  ensure  => present,
  mode    => '0744',
  content => 'Hello World!',
  owner   => 'root',
  group   => 'root'
}

exec { 'insert_block':
  command => '/usr/bin/sed -i "s|server_name_;|server_name_;\n\tlocation /redirect_me {\n\t\treturn 301 https://twitter.com/jamesmatics;\n\t}|" /etc/nginx/sites-available/default',
  require => File['/var/www/html/index.html'],
  notify  => Exec['nginx restart']
}
