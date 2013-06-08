# == Class:common::bash
#
# This class parses a <tt>common::bash_aliases</tt> hash from Hiera,
# and passes it on to the <tt>common::bash_alias</tt> definition in order to
# create bash aliases on the system. See <tt>common::bash_alias</tt>
# definition for allowed keys and values.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# * Hiera Hash (use one space for indentation):
#     common::bash_aliases:
#       'my_alias':
#         command: '/usr/bin/my_command'
#         user: 'my_name'
#       'my_global_alias':
#         command: '/usr/bin/my_command'
#         user: 'global'
#
#
# * Instalation:
#     include common::users
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common::bash(
  $aliases = hiera_hash('common::bash_aliases', false)
) {

  #require common::users
  if $aliases {
    create_resources(common::bash_alias, $aliases)
  }
}

