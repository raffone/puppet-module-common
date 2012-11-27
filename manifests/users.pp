# == Class:common::users
#
# This class parses a <tt>users</tt> hash from Hiera (if present), and passes it
# on to the <tt>common::user_add</tt> definition in order to create users on the
# system. See <tt>common::user_add</tt> definition for allowed keys and values.
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
#     users:
#      myname:
#       ssh_key: 'r6uZ...WEEw=='
#       ssh_key_comment: 'My_RSA_Key'
#       sudo: true
#       priority: 99
#
# * Hiera Hash (Removal/decommissioning):
#     users:
#      myname:
#       ensure: absent
#
# * Instalation:
#     include common::users
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common::users(
  $users = hiera_hash('common::users', 'none')
) {

  if $users != 'none' {
    create_resources(common::user_add, $users)
  }
}

