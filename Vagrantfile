Vagrant.configure(2) do |config|

  config.vm.box              = 'puppetlabs/ubuntu-14.04-64-puppet'
  config.vm.box_version      = '1.0.1'
  config.vm.box_check_update = true

  config.vm.define "jawbox" do |jawbox|
		jawbox.vm.hostname = 'jawbox.dischord.org'
  end
  config.vm.define "trillian" do |trillian|
		trillian.vm.hostname = 'trillian.dischord.org'
  end
  config.vm.define "void" do |void|
		void.vm.hostname = 'void.dischord.org'
  end

  config.vm.provision 'shell', path: 'vagrant/bootstrap_client.sh'
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = 'vagrant'
    puppet.module_path = 'modules'
    puppet.hiera_config_path = 'vagrant/hiera.yaml'
    puppet.temp_dir = "/tmp"
    puppet.options = [ "--verbose", "--debug" ]
  end

end
