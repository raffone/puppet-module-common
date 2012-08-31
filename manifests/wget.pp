# == Define: common::wget
#
# This definition uses wget to download a file.
#
#
# === Parameters
#
# [*source*]
#   String (*required*). The Source URL.
#
# [*destination*]
#   String (*required*). The path and name for downloaded file.
#
#
# === Examples
#
#     common::wget {'My File':
#       source      => 'http://www.example.com/downloads/file.zip',
#       destination => '/tmp/file.zip'
#     }
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
define common::wget ($source, $destination) {

  exec {"wget-${name}":
    command => "/usr/bin/wget --output-document=${destination} ${source}",
    creates => $destination,
  }

}

