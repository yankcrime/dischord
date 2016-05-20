# == Class profile::common
#
class profile::common {

  include ::apt

  create_resources(user, hiera('users'))
  create_resources(package, hiera('packages'))

  service { 'puppet':
    ensure => stopped,
  }

}
