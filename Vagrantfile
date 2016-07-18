# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!


overrides_json = File.dirname(__FILE__)+"/overrides.json"

unless File.exists?(overrides_json)
		raise "Couldn't find #{overrides_json}. See overrides.json.example"
end

overrides = JSON.parse(IO.read(overrides_json))

VAGRANTFILE_API_VERSION = "2"

if ! Dir.exist?(File.dirname(__FILE__)+"/berks-cookbooks") then
    Dir.mkdir(File.dirname(__FILE__)+"/berks-cookbooks")
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|


	config.vm.box = "centos6-raven"
	config.vm.box_url = "http://raven-opensource.s3.amazonaws.com/boxes/centos6-raven.json"

	config.vm.network :private_network, ip: "10.55.10.10"
	config.vm.network :forwarded_port, guest: 8000, host: 8099 # http
	config.vm.network :forwarded_port, guest: 8086, host: 8086 # influxdb

	config.vm.provision :shell, path: "scripts/vagrant_bootstrap.sh"

	config.vm.provision :chef_solo do |chef|
		chef.install = false
		chef.cookbooks_path = "berks-cookbooks"
		chef.roles_path = "roles"
		chef.add_role "vagrant"
		chef.json = overrides
	end

	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--rtcuseutc", "on", "--memory", "2048", "--cpus", "2", "--natdnshostresolver1", "on"]
	end

end
