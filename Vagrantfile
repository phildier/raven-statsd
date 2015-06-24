# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    if ::File.exists? "overrides.json" then
        overrides = JSON.parse(File.open("overrides.json").read)
    else
        overrides = {}
    end

	config.vm.box = "centos64"
	config.vm.network :private_network, ip: "192.168.34.10"
	config.vm.network :forwarded_port, guest: 80, host: 8099 # http
	config.vm.network :forwarded_port, guest: 8086, host: 8086 # influxdb

	config.vm.provision :shell, path: "scripts/vagrant_bootstrap.sh"

	config.vm.provision :chef_solo do |chef|
		chef.cookbooks_path = [".","berks-cookbooks"]
		chef.roles_path = "roles"
		chef.add_role "vagrant"
		chef.json = overrides
	end

	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--rtcuseutc", "on", "--memory", "2048", "--cpus", "2", "--natdnshostresolver1", "on"]
	end

end

# vim:set syntax=ruby ts=4 sw=4:
