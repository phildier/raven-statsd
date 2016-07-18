chef_gem 'influxdb'

package "influxdb"
package "collectd"

directory node[:raven_statsd][:influxdb][:base_dir] do
	action :create
	owner 'influxdb'
	group 'influxdb'
	mode '0755'
end

template "/etc/influxdb/influxdb.conf" do
	source "influxdb.conf.erb"
	variables ({
			:base_dir => node[:raven_statsd][:influxdb][:base_dir],
			:http_port => node[:raven_statsd][:influxdb][:http_port],
			:enable_graphite => node[:raven_statsd][:influxdb][:enable_collectd],
			:collectd_port => node[:raven_statsd][:influxdb][:collectd_port],
			:collectd_db => node[:raven_statsd][:influxdb][:collectd_db],
			:enable_graphite => node[:raven_statsd][:influxdb][:enable_graphite],
			:graphite_port => node[:raven_statsd][:influxdb][:graphite_port],
			:graphite_db => node[:raven_statsd][:influxdb][:graphite_db]
			})
	notifies :restart, "service[influxdb]"
end

service "influxdb" do
	action [:start, :enable]
end

ruby_block 'create_influx_stuff' do
	block do
		require 'influxdb'
		influx_client =  InfluxDB::Client.new(  username: node[:raven_statsd][:influxdb][:adminuser] , password: node[:raven_statsd][:influxdb][:adminpass] , retry: 10 )
		influx_client.create_cluster_admin(node[:raven_statsd][:influxdb][:adminuser],node[:raven_statsd][:influxdb][:adminpass])
		influx_client.create_database("test")
		influx_client.create_database_user("test",node[:raven_statsd][:influxdb][:user],node[:raven_statsd][:influxdb][:password])
		node[:raven_statsd][:influxdb][:dbs].each do |db|
				next if influx_client.list_databases.map { |x| x['name'] }.member?(db)
				influx_client.create_database(db)
		end
		node[:raven_statsd][:influxdb][:dbs].each do |db|
				influx_client.grant_user_privileges(node[:raven_statsd][:influxdb][:user],db,:all)
		end
	end
end
