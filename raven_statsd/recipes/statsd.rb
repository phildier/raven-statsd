include_recipe "raven_statsd::supervisor"

package "python-bucky"

template "/etc/supervisor.d/statsd.conf" do
	source "supervisor_program.conf.erb"
	variables ({
			:name => "statsd",
			:command => "bucky --statsd-ip=0.0.0.0",
			:directory => "/tmp",
			:numprocs => 1,
			:user => "nobody"
			})
	notifies :restart, "service[supervisord]", :delayed
end
