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

  apt::source { 'puppetlabs.com':
    location    => 'http://apt.puppetlabs.com',
    key         => '4BD6EC30',
    key_server  => 'pgp.mit.edu',
    include_src => true,
  }

}

