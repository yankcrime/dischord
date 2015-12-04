# == Class profile::serf
#
class profile::serf {

  include ::serf

  file { '/etc/serf/handlers':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Class['::serf'],
  }

  file { '/etc/serf/handlers/puppet':
    source  => 'puppet:///modules/profile/puppet',
    path    => '/etc/serf/handlers/puppet',
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    require => File['/etc/serf/handlers'],
  }
}
