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

  $release_deb = "puppetlabs-release-${::lsbdistcodename}.deb"
  $deb_path = "${common::debs_dir}/${release_deb}"

  common::wget {'PuppetLabs Release':
    source      => "http://apt.puppetlabs.com/${release_deb}",
    destination => $deb_path,
  }

  exec {'Install PuppetLabs Release':
    command => "/usr/bin/dpkg -i ${deb_path}",
    creates => [
      '/etc/apt/sources.list.d/puppetlabs.list',
      '/etc/apt/trusted.gpg.d/puppetlabs-keyring.gpg'
    ],
    require => Common::Wget ['PuppetLabs Release'],
    notify  => Class['apt::update'],
  }

  #apt::source { 'puppetlabs':
    #location    => 'http://apt.puppetlabs.com',
    #key         => '4BD6EC30',
    #key_server  => 'pgp.mit.edu',
    #include_src => true,
  #}

}

