#
# == Class: ::profile::containers
#
# Quick and dirty way of defining some containers to run
#
class profile::containers {

  create_resources(docker::run, hiera('containers'))

}
