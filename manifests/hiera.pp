# == Definition: accounts::hiera
#
# Helper class to create users and authorized keys files.
#
# === Parameters:
#
# [*uid*]
#
# [*gid*]
#
# [*ensure*]
#
# [*groups*]
#
# [*home*]
#
# [*shell*]
#
# [*authorized_keys*]
#
# [*password*]
#
# === Usage:
#
# You shouldn't be using this really. It's used by the accounts class, which is
# all you need.
#
# Unless you want to add stuff, in that case, pull requests welcome!
#
define accounts::hiera (
  $uid,
  $gid             = 100,
  $ensure          = 'present',
  $groups          = [],
  $home            = "/home/${name}",
  $shell           = '/bin/bash',
  $managehome      = true,
  $authorized_keys = undef,
  $password        = undef,
) {

  user {$name:
    ensure     => $ensure,
    uid        => $uid,
    gid        => $gid,
    groups     => $groups,
    home       => $home,
    shell      => $shell,
    managehome => $managehome,
  }

  if ($password and $::virtual != 'xen0') {
    User[$title] {
      password         => $password,
      password_max_age => '99999',
    }
  }

  $dir_ensure = $ensure ? {
    'present' => 'directory',
    default   => $ensure,
  }

  file {"/home/${name}/.ssh":
    ensure  => $dir_ensure,
    mode    => '0700',
    backup  => false,
  }
  file {"/home/${name}/.ssh/authorized_keys":
    ensure  => $ensure,
    mode    => '0600',
    content => $authorized_keys,
    backup  => false,
  }

  if $ensure != 'absent' {
    File["/home/${name}/.ssh"] {
      owner   => $name,
      group   => $gid,
      require => User[$name],
    }
    File["/home/${name}/.ssh/authorized_keys"] {
      owner   => $name,
      group   => $gid,
    }
  }
  else {
    File["/home/${name}/.ssh"] {
      force => true,
    }
  }

}
