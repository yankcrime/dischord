# == Class profile::common
#
class profile::common {

  create_resources(user, hiera('users'))

}
