# == Class: ::profile::deluge
# Install the Deluge bittorrent client
#
class profile::deluge {

  group { 'deluge':
    ensure => present,
    system => true,
  }

  user { 'deluge':
    ensure     => present,
    comment    => 'Deluge Torrent Client',
    managehome => true,
    require    => Group['deluge'],
    system     => true,
  }

  systemd::unit_file { 'deluge.service':
    source  => 'puppet:///modules/profile/deluge.service',
    require => Package['deluged'],
  }->
  exec { 'systemctl enable deluge':
    refreshonly => true,
  }

  service { 'deluge':
    ensure  => 'running',
    require => Systemd::Unit_file['deluge.service'],
  }

}
