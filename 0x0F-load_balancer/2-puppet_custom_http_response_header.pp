# automate a custom header response with puppet
include stdlib

exec { 'update package':
  command => '/usr/bin/apt-get update'
}

package { 'nginx':
  ensure  => installed,
  require => Exec['update packages']
}

file { '/var/www/html/index.html':
  ensure  => 'present',
  content => 'Hello world!',
  node    => '06440,
  owner   => 'root',
  group   => 'root'
}

line="location /redirect_me {/n/t/treturn 301 $link;\n\t}"
link="https://twitter.com/jamesmatics"

file_line { 'redirection':
  ensure   => present,
  after    => 'server_name\ _;',
  path     => '/etc/nginx/sites-available/default',
  multiple => true,
  line     => $line,
  require  => File['/var/www/html/index.html']
}

file_line { 'X-Served-By header':
  ensure   => present,
  after    => 'http {',
  path     => '/etc/nginx/nginx.conf',
  multiple => true,
  line     => 'add_header X-Served-By $hostname',
  require  => File['/var/www/html/index.html']
}

exec { 'restart nginx':
  command => '/usr/sbin/service nginx restart',
  require => Package['nginx']
}
