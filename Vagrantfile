# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    # Every Vagrant virtual environment requires a box to build off of.
	config.vm.box = 'debian64'
    
	# The url from where the 'config.vm.box' box will be fetched if it
	# doesn't already exist on the user's system.
	# config.vm.box_url = "http://domain.com/path/to/above.box"
	
	# Create a private network, which allows host-only access to the machine
	# using a specific IP.
	config.vm.network 'private_network', ip: '192.168.3.2'
	
	# Enable provisioning with Puppet stand alone.  Puppet manifests
	# are contained in a directory path relative to this Vagrantfile.
	# You will need to create the manifests directory and a manifest in
	# the file default.pp in the manifests_path directory.
    config.vm.provision "puppet" do |puppet|
	   puppet.manifests_path = "manifests"
	   puppet.manifest_file  = "default.pp"
	end
    
	# Share an additional folder to the guest VM. The first argument is
	# the path on the host to the actual folder. The second argument is
	# the path on the guest to mount the folder. And the optional third
	# argument is a set of non-required options.
	config.vm.synced_folder 'C:\www', '/var/www'
  
    # Provider-specific configuration so you can fine-tune various
	# backing providers for Vagrant. These expose provider-specific options.
	config.vm.provider "virtualbox" do |v|
        v.memory = 384
    end
	
	#hostmanager
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = true
	config.hostmanager.include_offline = true
	config.vm.hostname = 'alpha.local'
end