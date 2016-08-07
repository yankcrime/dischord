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

  nginx::resource::location { 'sonarr':
    vhost            => 'default',
    location         => '/sonarr',
    proxy_set_header => [ 'X-Real-IP $remote_addr', 'X-Forwarded-For $proxy_add_x_forwarded_for' ],
    proxy_redirect   => 'off',
    proxy            => 'http://127.0.0.1:8989',
  }

}
