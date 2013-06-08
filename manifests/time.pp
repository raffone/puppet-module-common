# == Class: common::time
#
# This class sets the timezone on the server.
# Look inside the <tt>/usr/share/zoneinfo/</tt> folder for valid values.
#
#
# === Parameters
#
# [*zone*]
#   String. The file to be created.
#   Defaults to <tt>UTC</tt>.
#
#
# === Examples
#
# * Installation:
#     class {'common::time': zone => 'US/Central'}
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common::time (
  $zone = 'UTC'
) {

  case $::operatingsystem {
    'Ubuntu', 'Debian': {
      package {'tzdata':
        ensure => present,
      }
      file {
        '/etc/localtime':
          ensure  => link,
          target  => "/usr/share/zoneinfo/${zone}",
          require => Package['tzdata'];
        '/etc/timezone':
          content => "${zone}\n";
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

}

