# == Class:common::repo_vlad
#
# This class installs Vlad Ghinea's Launchpad Repository.
# https://launchpad.net/~vladgh/+archive/stable
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
#     include common::repo_vlad
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common::repo_vlad {

  apt::ppa { 'ppa:vladgh/stable': }

}

