# == Class: common::extra
#
# This class installs a few extra packages.
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
#     include common::extra
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common::extra {

  # Install essential Ubuntu packages
  $extra_packages=[
    'vim-nox',
    'screen',
    'htop',
    'lynx',
    'unzip',
    'zip',
    'ntp',
    'ntpdate',
    'python-software-properties',
    'build-essential'
  ]

  case $::operatingsystem {
    'Ubuntu', 'Debian': {
      ensure_packages($extra_packages)
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

}
