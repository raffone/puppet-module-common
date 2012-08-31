# == Class: common::swapfile
#
# This class creates a local swap files.
#
#
# === Parameters
#
# [*file*]
#   String. The file to be created.
#   Defaults to <tt>/var/swap.space</tt>.
#
# [*size*]
#   Integer. The size of the swap space (in MB).
#   Defaults to <tt>512</tt>.
#
#
# === Examples
#
# * Installation:
#     common::swapfile {'My Swap Space':
#       file => '/var/swap.space',
#       size => 512,
#     }
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common::swapfile(
  $file = '/var/swap.space',
  $size = '512'
) {

  exec {'Create swap file':
    command => "/bin/dd if=/dev/zero of=${file} bs=1M count=${size}",
    creates => $file,
  }

  exec {'Attach swap file':
    command => "/sbin/mkswap ${file} && /sbin/swapon ${file}",
    require => Exec ['Create swap file'],
    unless  => "/sbin/swapon -s | grep ${file}",
  }

}

