# == Define: common::bash_alias
#
# This module adds an alias into user's <tt>.bashrc</tt> file.
#
#
# === Parameters
#
# [*ensure*]
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>.
#   Defaults to <tt>present</tt>.
#
# [*command*]
#   String. The command to be aliased.
#   Defaults to <tt>nil</tt>.
#
# [*user*]
#   String. The user for which the command will be aliased.
#   If not specified the alias is added to the global bashrc file.
#   Defaults to <tt>nil</tt>.
#
#
# === Examples
#
# * Installation:
#     common::bash_alias {'update_system':
#       command => 'sudo apt-get update && sudo apt-get upgrade',
#       user    => 'myname',
#     }
#
# * Removal/decommissioning:
#     common::bash_alias {'update_system':
#       ensure  => 'absent',
#       command => 'sudo apt-get update && sudo apt-get upgrade',
#       user    => 'myname',
#     }
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
define common::bash_alias(
  $ensure = 'present',
  $command = nil,
  $user = nil,
) {

  # Validate parameters
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  }

  case $user {
    root: {$file = '/root/.bashrc'}
    nil: {$file = '/etc/bash.bashrc'}
    default: {$file = "/home/${user}/.bashrc"}
  }

  file_line {"Alias ${name}":
    ensure  => $ensure,
    path    => $file,
    line    => "alias ${name}=\'${command}\'",
    match   => "^alias ${name}=\'.*\'$",
    require => Class['common::users']
  }
}

