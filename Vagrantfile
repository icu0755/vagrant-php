VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = 'icu0755/ubuntu64'
	config.vm.box_url = "https://vagrantcloud.com/icu0755/vagrant-ubuntu-trusty64/version/1/provider/virtualbox.box"
	
	config.vm.network 'private_network', ip: '192.168.3.2'
	config.vm.network "forwarded_port", guest: 80, host: 8888
	
    config.vm.provision "puppet" do |puppet|
	   puppet.manifests_path = 'puppet/manifests'
	   puppet.manifest_file  = 'default.pp'
	   puppet.module_path = 'puppet/modules'
#	   puppet.options = "--verbose --debug"
	end
    
	# vagrant plugin install vagrant-winnfsd
	config.vm.synced_folder 'C:\www', '/var/www', create: true, nfs: true

	config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
        v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
end