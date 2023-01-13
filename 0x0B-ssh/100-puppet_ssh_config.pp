# using puppet to set up config file for ssh

file { '/etc/ssh/config':
  ensure  => file,
  mode    => '600',
  owner   => 'ubuntu',
  content => '# ssh_conf950 man page\n; Include /etc/ssh/ssh_config.d/*.conf\n; Host *\n;
  PubKeyAuthentication yes\n;
  IndentityFile ./.ssh/school\n;
  GSSAPIAuthentication yes\n;
  SendEnv LANG LC_*\n;
  HashKnownHosts yes\n',
}
