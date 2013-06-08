# == Class: common::repo::vladgh
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
#     include common::repo::vladgh
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common::repo::vladgh {

  apt::ppa { 'ppa:vladgh/stable': }

}

