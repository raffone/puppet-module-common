# == Class: common
#
# This class adds common functions and variables to the catalog. It also
# installs a set of useful packages for Ubuntu.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# * Standalone:
#     include common
#
#
# === Authors
#
# * Vlad Ghinea <mailto:vgit@vladgh.com>
#
class common {

  # Remove annoyances
  include common::annoyances

  # Include extra packages
  include common::extra

  # Set Time Zone
  include common::time

  # Bash aliases
  include common::bash

  # Users
  include common::users

  # Cron Jobs
  include common::cron

}

