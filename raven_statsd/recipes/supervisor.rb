
include_recipe "raven_statsd::default"

[
	["python-meld3","python-meld3-0.6.10-1.noarch.rpm"],
	["python-setuptools","python-setuptools-2.2-1.noarch.rpm"],
	["python-supervisor","python-supervisor-3.0-1.noarch.rpm"]
].each do |n,r|
	tmp_path = "#{node[:raven_statsd][:tmp_dir]}/#{r}"
	remote_file tmp_path do
		source "#{node[:raven_statsd][:attachment_url]}/#{r}"
	end

	rpm_package n do
		source tmp_path
	end
end

# init.d script
template "/etc/rc.d/init.d/supervisord" do
	source "supervisord.erb"
	mode 0755 
end

# include dir for managed programs
directory "/etc/supervisor.d" do
	action :create
end

# daemon/client config
template "/etc/supervisord.conf" do
	source "supervisord.conf.erb"
	variables ({
			:port => node[:raven_statsd][:supervisord][:port],
			:username => node[:raven_statsd][:supervisord][:username],
			:password => node[:raven_statsd][:supervisord][:password]
			})
end

# start it up
service "supervisord" do
	supports [ :start, :stop, :restart, :status ]
	action :start
end
