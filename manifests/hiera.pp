# == Definition: accounts::hiera
#
# Helper class to create users and authorized keys files.
#
# === Parameters:
#
# Most parameters are a one-on-one mapping with the user resource.
# Read the puppet documentation on their use.
#
# [*uid*]: See `user::uid`.
#
# [*gid*]: See `user::gid`.
#
# [*ensure*]: Create or remove the user. Allowed values are 'present' and 'absent'.
#
# [*groups*]: See `user::groups`.
#
# [*home*]: See `user::home`.
#
# [*shell*]: See `user::shell`.
#
# [*authorized_keys*]: Content to put in the ssh authorized_keys file.
#
# [*password*]: See `user::password`.
#
# [*managehome*]: See `user::managehome`.
#
# [*extra_params*]: A hash with extra parameters assigned to the user resource.
#
#
# === Usage:
#
# You shouldn't be using this really. It's used by the accounts class, which is
# all you need.
#
# Unless you want to add stuff, in that case, pull requests welcome!
#
define accounts::hiera (
  Integer[0]                  $uid,
  Integer[0]                  $gid             = 100,
  Enum['present','absent']    $ensure          = 'present',
  Array                       $groups          = [],
  String                      $home            = "/home/${name}",
  String                      $shell           = '/bin/bash',
  Boolean                     $managehome      = true,
  Optional[String]            $authorized_keys = undef,
  Optional[String]            $password        = undef,
  Hash                        $extra_params    = {},
) {

  create_resources('user',
    {
      "${name}" => {
        'ensure'     => $ensure,
        'uid'        => $uid,
        'gid'        => $gid,
        'groups'     => $groups,
        'home'       => $home,
        'shell'      => $shell,
        'managehome' => $managehome,
      }
    },
    $extra_params
  )

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
    ensure => $dir_ensure,
    mode   => '0700',
    backup => false,
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
