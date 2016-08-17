# == Class: ::profile::sonarr
class profile::sonarr {

  systemd::unit_file { 'sonarr.service':
    source  => 'puppet:///modules/profile/sonarr.service',
    require => Package['nzbdrone'],
  }->
  exec { 'systemctl enable sonarr':
    refreshonly => true,
  }

  service { 'sonarr':
    ensure  => 'running',
    require => Systemd::Unit_file['sonarr.service'],
  }

}
