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
#   Defaults to <tt>empty</tt>.
#
# [*user*]
#   String. The user for which the command will be aliased.
#   You can use <tt>global</tt> to add an alias to the global bashrc file.
#   Defaults to <tt>root</tt>.
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
  $command = '',
  $user = 'root',
) {

  # Validate parameters
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  }

  case $user {
    global: {$file = '/etc/bash.bashrc'}
    root: {$file = '/root/.bashrc'}
    default: {$file = "/home/${user}/.bashrc"}
  }

  file_line {"Alias ${name}":
    ensure => $ensure,
    path   => $file,
    line   => "alias ${name}=\'${command}\'",
    match  => "^alias ${name}=\'.*\'$",
  }
}

