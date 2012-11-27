# == Define: common::cron_jobs
#
# This class retrieves cron jobs and parameters from hiera.
#
#
# === Parameters
#
# [*ensure*]
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>.
#   Defaults to <tt>present</tt>.
#
# [*command*]
#   String. The command to be aliased.
#   Defaults to <tt>empty</tt>.
#
# [*user*]
#   String. The user for which the command will be aliased.
#   Defaults to <tt>root</tt>.
#
#
# === Examples
#
# * Installation:
#     common::bash_alias {'update_system':
#       command => 'sudo apt-get update && sudo apt-get upgrade',
#       user    => 'myname',
#     }
#
# * Removal/decommissioning:
#     common::bash_alias {'update_system':
#       ensure  => 'absent',
#       command => 'sudo apt-get update && sudo apt-get upgrade',
#       user    => 'myname',
#     }
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common::cron_jobs(
  $jobs = hiera_hash('cron_jobs', undef)
) {

  if $jobs {
    create_resources(cron, $jobs)
  }
}

