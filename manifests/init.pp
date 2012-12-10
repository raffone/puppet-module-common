# == Class: common
#
# This class adds common functions and variables to the catalog. It also
# installs a set of useful packages for Ubuntu.
#
# Read more about the custom mount points and file sources in the main
# {README}[http://j.mp/TAEVWT] file.
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
    owner   => 'root',
    group   => 'root',
    source  => ["${source1}/scripts",
                "${source2}/scripts",
                "${source3}/scripts",
                "${source4}/scripts",
                'puppet:///modules/common/empty'],
  }

  # Install essential Ubuntu packages
  $ubuntu_packages=[
    'htop',
    'vim-nox',
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

