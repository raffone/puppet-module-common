# == Class: common
#
# This class adds common functions and variables to the catalog. It also
# installs a set of useful packages for Ubuntu.
#
# Custom functions:
#
# * facter_dot_d: Facter plugin that loads facts from /etc/facter/facts.d
#   and /etc/puppetlabs/facter/facts.d.
#   (https://github.com/vladgh/puppet-module-common/blob/master/lib/facter/facter_dot_d.rb)
#
# * sources_array: It looks for the 'file_source_hierarchy' array defined in
#   hiera or in the top scope to generate an array of complete puppet file
#   server URI.
#   (https://github.com/vladgh/puppet-module-common/blob/master/lib/puppet/parser/functions/sources_array.rb)
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# * Standalone:
#     include common
#
# * In other modules:
#     require common
#     $packages_store  = $common::debs_dir
#     $path_to_scripts = $common::scripts_dir
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common {

  # Remove annoyances
  include common::annoyances

  # Common Directories Storage
  $debs_dir    = hiera('debs_dir', '/usr/src')
  $scripts_dir = hiera('scripts_dir', '/usr/scripts')

  # Create a folder for scripts
  file {'Scripts Folder':
    ensure  => directory,
    path    => $scripts_dir,
    recurse => true,
    force   => true,
    purge   => true,
    owner   => 'root',
    group   => 'root',
    source  => sources_array(
      $::private_files,
      'scripts',
      'puppet:///modules/common/empty'
    ),
  }

  # Install essential Ubuntu packages
  $ubuntu_packages=[
    'vim-nox',
    'screen',
    'htop',
    'lynx',
    'unzip',
    'zip',
    'ntp',
    'ntpdate',
    'python-software-properties',
    'build-essential',
    'ruby',
    'ruby-dev',
    'rubygems',
    'libxml2-dev',
    'libxslt1-dev'
  ]

  case $::operatingsystem {
    'Ubuntu', 'Debian': {
      package {$ubuntu_packages: ensure  => present}
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }


}

