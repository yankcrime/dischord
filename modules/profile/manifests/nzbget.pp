# == Class: ::profile::nzbget
#
# Install and configure nzbget
#
class profile::nzbget {

  package { 'nzbget':
    ensure => latest,
  }

  systemd::unit_file { 'nzbget.service':
    source  => 'puppet:///modules/profile/sonarr.service',
    require => Package['nzbget'],
  }->
  exec { 'systemctl enable nzbget':
    refreshonly => true,
  }

  service { 'nzbget':
    ensure  => 'running',
    require => Systemd::Unit_file['nzbget.service'],
  }

}
