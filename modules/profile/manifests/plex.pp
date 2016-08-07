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

  service { 'plexmediaserver':
    ensure  => 'running',
    require => Package['plexmediaserver'],
  }

  nginx::resource::location { 'root':
    vhost            => 'default',
    location         => '/plex',
    proxy_set_header => [ 'X-Real-IP $remote_addr', 'X-Forwarded-For $proxy_add_x_forwarded_for', 'Host $http_host' ],
    proxy_redirect   => 'off',
    proxy            => 'http://127.0.0.1:32400',
  }

}
