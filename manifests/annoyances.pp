# == Class: common::annoyances
#
# This class fixes some annoyances.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# * Standalone:
#     include common::annoyances
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common::annoyances {

  case $::operatingsystem {
    'Ubuntu': {
      package {'popularity-contest': ensure  => purged}
    }
    default: {
    }
  }

}
