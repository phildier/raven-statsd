package "grafana"

directory node[:raven_statsd][:grafana][:data_dir] do
	user "grafana"
	group "grafana"
end

template "/etc/grafana/grafana.ini" do
	source "grafana.ini.erb"
	variables ({
		:data_dir => node[:raven_statsd][:grafana][:data_dir],
		:fqdn => node[:raven_statsd][:grafana][:fqdn],
		:public_fqdn => node[:raven_statsd][:grafana][:public_fqdn],
		:http_port => node[:raven_statsd][:grafana][:http_port],
		:admin_username => node[:raven_statsd][:grafana][:admin][:username],
		:admin_password => node[:raven_statsd][:grafana][:admin][:password],
		:google_client_id => node[:raven_statsd][:grafana][:google][:client_id],
		:google_client_secret => node[:raven_statsd][:grafana][:google][:client_secret],
		:google_domain => node[:raven_statsd][:grafana][:google][:domain]
	})
	notifies :restart, "service[grafana-server]", :delayed
end

service "grafana-server" do
	action [ :start, :enable ]
end

my_message = {
	"name" => 'local_influxdb',
	"type" => 'influxdb',
	"access" => 'direct',
	"url" => "http://127.0.0.1:#{node[:raven_statsd][:influxdb][:http_port]}",
	"password" => node[:raven_statsd][:influxdb][:password],
	"user" => node[:raven_statsd][:influxdb][:user],
	"database" => node[:raven_statsd][:influxdb][:collectd_db],
	"isDefault" => true
}.to_json


bash 'create_influxdb_data_source' do
	not_if "curl -s http://#{node[:raven_statsd][:grafana][:admin][:username]}:#{node[:raven_statsd][:grafana][:admin][:password]}@127.0.0.1:#{node[:raven_statsd][:grafana][:http_port]}/api/datasources |grep -q id"
	code <<-EOH
	curl -H 'Content-Type: application/json' -X POST -d '#{my_message}' -s http://#{node[:raven_statsd][:grafana][:admin][:username]}:#{node[:raven_statsd][:grafana][:admin][:password]}@127.0.0.1:#{node[:raven_statsd][:grafana][:http_port]}/api/datasources 2>&1 >>/tmp/tmp
	EOH
end
