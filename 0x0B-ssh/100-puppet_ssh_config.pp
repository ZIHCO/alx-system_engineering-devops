# using puppet to set up config file for ssh
include <stdlib>


file_line { 'Turn off password':
  path    => '/etc/ssh/ssh_config',
  ensure  => 'present',
  line    => 'PasswordAuthentication no',
  match   => '^PasswordAuthentication'
}

file_line { 'Identity file assignment':
  path    => '/etc/ssh/ssh_config',
  ensure  => 'present',
  line    => 'IdentityFile ~/.ssh/school',
  match   => '^IdentityFile'
}
