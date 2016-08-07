Vagrant.configure(2) do |config|

  config.vm.box              = 'puppetlabs/ubuntu-16.04-64-puppet'
  config.vm.box_version      = '1.0.0'
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

  config.vm.define "pavilion" do |pavilion|
		pavilion.vm.hostname = 'pavilion.int.dischord.org'
  end

  # Provision the box
  config.vm.provision 'shell', path: 'vagrant/bootstrap_client.sh'
  config.vm.provision 'puppet' do |puppet|
    puppet.binary_path       = '/opt/puppetlabs/bin'
    puppet.environment       = 'dischord'
    puppet.environment_path  = '..'
    puppet.hiera_config_path = 'vagrant/hiera.yaml'
    puppet.options = [ '--verbose' ]
  end
end
