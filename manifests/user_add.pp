# == Define: common::user_add
#
# This definition adds users, with authorized ssh keys, and a sudo environment.
#
#
# === Parameters
#
# [*ensure*]
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>.
#   Defaults to <tt>present</tt>.
#
# [*ssh_key*]
#   String. The public key to enter in the authorized_keys file (the part
#   between <tt>ssh-rsa ...</tt> and the key comment).
#   Defaults to <tt>false</tt>.
#
# [*ssh_key_comment*]
#   String. A comment for the specified key (no spaces).
#   Defaults to <tt>NO_COMMENT</tt>.
#
# [*sudo*]
#   Boolean or <tt>password</tt>. If set to <tt>true</tt>, the specified user
#   will have sudo privileges. If set to <tt>password</tt>, the user will be
#   asked for the password when running with sudo privileges.
#   Defaults to <tt>false</tt>.
#
# [*priority*]
#   Integer. The priority inside the <tt>/etc/sudoers.d</tt> folder.
#   Defaults to <tt>10</tt>.
#
#
# === Examples
#
# * Installation:
#     common::user_add {'myname':
#       ssh_key         => 'AAAA.....xyz==',
#       ssh_key_comment => 'My_RSA_Key',
#       sudo            => true,
#       priority        => 99,
#     }
#
# * Removal/decommissioning:
#     common::user_add {'myname':
#       ensure => 'absent',
#     }
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
define common::user_add (
  $ensure = 'present',
  $ssh_key = false,
  $ssh_key_comment = 'NO_COMMENT',
  $sudo = false,
  $priority = 10,
) {

  # Validate parameters
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  }

  $sudo_config_dir = '/etc/sudoers.d'
  $home            = "/home/${name}"

  # User
  user {$name:
    ensure     => $ensure,
    home       => $home,
    shell      => '/bin/bash',
    managehome => true,
  }

  # Key
  if $ssh_key {
    ssh_authorized_key {"SSH_${name}":
      ensure  => $ensure,
      key     => $ssh_key,
      name    => "${name}_${ssh_key_comment}",
      type    => 'ssh-rsa',
      user    => $name,
      require => User [$name],
    }
  }

  # Sudo
  case $sudo {
    true: {
      file {"Sudo ${name}":
        ensure  => present,
        path    => "${sudo_config_dir}/${priority}-${name}",
        content => "${name} ALL=(ALL) NOPASSWD:ALL",
        owner   => 'root',
        group   => 'root',
        mode    => '0440',
        require => User [$name],
      }
    }
    false: {
      file {"Sudo ${name}":
        ensure  => absent,
        path    => "${sudo_config_dir}/${priority}-${name}",
        require => User [$name],
      }
    }
    'password': {
      file {"Sudo ${name}":
        ensure  => present,
        path    => "${sudo_config_dir}/${priority}-${name}",
        content => "${name} ALL=(ALL) ALL",
        owner   => 'root',
        group   => 'root',
        mode    => '0440',
        require => User [$name],
      }
    }
    default: { fail('Unknown sudo value') }
  }

  # Dotfiles
  file {$home:
    ensure  => directory,
    recurse => true,
    owner   => $name,
    group   => $name,
    source  => sources_array(
      $::private_files,
      $home,
      'puppet:///modules/common/empty'
    ),
  }

}

