# == Class profile::common
#
class profile::common {

  include ::apt

  # Ensure an apt-get update happens before any package installs
  Class['apt::update'] -> Package <| |>

  create_resources(user, hiera('users'))
  create_resources(package, hiera('packages'))
  create_resources(ssh_authorized_key, hiera('sshkeys'))

  service { 'puppet':
    ensure => stopped,
  }

}
