# == Define: common::cron
#
# This class creates cron jobs from a hash of cron resources.
#
#
# === Parameters
#
# [*jobs*]
#   Hash. Cron jobs.
#   Defaults to <tt>hiera_hash('common::cron_jobs', false)</tt>.
#
#
# === Examples
#
# * Installation:
#     include common::cron
#
#   Hiera Data:
#     ---
#     # Cron Jobs
#     common::cron_jobs:
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
class common::cron(
  $jobs = hiera_hash('common::cron_jobs', false)
) {

  if $jobs {
    create_resources(cron, $jobs)
  }
}

