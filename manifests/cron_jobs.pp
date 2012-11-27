# == Define: common::cron_jobs
#
# This class retrieves cron jobs and parameters from hiera.
#
#
# === Parameters
#
# [*jobs*]
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>.
#   Defaults to <tt>present</tt>.
#
#
# === Examples
#
# * Installation:
#     include common::cron_jobs
#
#   Hiera Data:
#     ---
#     # Cron Jobs
#     cron_jobs:
#      'Example Job':
#       ensure: present
#       command: 'echo'
#       user: 'root'
#       hour: '*/6'
#       minute: '30'
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

