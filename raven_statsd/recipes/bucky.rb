

include_recipe "raven-supervisor"
package "python-bucky"


if node[:raven_statsd][:bucky][:enable] != "false" then
	raven_supervisor_program "statsd_bucky" do
		command "/usr/bin/bucky --statsd-ip=0.0.0.0 --disable-metricsd --disable-collectd --graphite-ip=127.0.0.1 --graphite-port=#{node[:raven_statsd][:influxdb][:graphite_port]}"
		directory "/tmp"
		numprocs 1
		user "nobody"
		notifies :restart, "service[supervisord]", :delayed
		create_dir false
	end
end
