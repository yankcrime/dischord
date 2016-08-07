# == Class profile::common
#
class profile::common {

  include ::apt

  # Ensure an apt-get update happens before any package installs
  Class['apt::update'] -> Package <| |>

  create_resources(user, hiera('users'))
  create_resources(package, hiera('packages'))

  service { 'puppet':
    ensure => stopped,
  }

}
