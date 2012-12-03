# == Class:common::repo_puppetlabs
#
# This class installs the PuppetLabs Repository.
# http://apt.puppetlabs.com/
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# * Instalation:
#     include common::repo_puppetlabs
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common::repo_puppetlabs {

  common::wget {'PuppetLabs Release':
    source      => "http://apt.puppetlabs.com/puppetlabs-release-${::lsbdistcodename}.deb",
    destination => $common::debs_dir,
  }

  package{'PuppetLabs Release':
    ensure   => present,
    provider => dpkg,
    source   => "${common::debs_dir}/puppetlabs-release-${::lsbdistcodename}.deb",
    require  => Common::Wget ['PuppetLabs Release'],
  }

  #apt::source { 'puppetlabs':
    #location    => 'http://apt.puppetlabs.com',
    #key         => '4BD6EC30',
    #key_server  => 'pgp.mit.edu',
    #include_src => true,
  #}

}

