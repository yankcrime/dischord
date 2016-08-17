# == Class: ::profile::plex
#
# Install Plex Media Server
#
class profile::plex {

  include ::wget
  include ::nginx

  $url = 'https://downloads.plex.tv/plex-media-server/1.0.3.2461-35f0caa'
  $package = 'plexmediaserver_1.0.3.2461-35f0caa_amd64.deb'

  wget::fetch { 'plexpackage':
    source      => "${url}/${package}",
    destination => '/tmp/',
  }

  package { 'plexmediaserver':
    ensure   => 'installed',
    provider => 'dpkg',
    source   => "/tmp/${package}",
    require  => Wget::Fetch['plexpackage'],
  }

  file { '/var/lib/plexmediaserver':
    owner   => 'nick',
    group   => 'nick',
    recurse => true,
    require => [ User['nick'], Package['plexmediaserver'] ],
    before  => Service['plexmediaserver'],
  }

  service { 'plexmediaserver':
    ensure  => 'running',
    require => Package['plexmediaserver'],
  }

  file_line { 'plex_user':
    path    => '/lib/systemd/system/plexmediaserver.service',
    line    => 'User=nick',
    match   => 'User=plex',
    require => Package['plexmediaserver'],
    notify  => Service['plexmediaserver'],
  }

  file_line { 'plex_group':
    path    => '/lib/systemd/system/plexmediaserver.service',
    line    => 'Group=nick',
    match   => 'Group=plex',
    require => Package['plexmediaserver'],
    notify  => Service['plexmediaserver'],
  }

}
