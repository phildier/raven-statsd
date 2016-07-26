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

directory "/usr/share/grafana/public/app/getdash"

cookbook_file "/usr/share/grafana/public/app/getdash/getdash.app.js" do
	source "getdash.app.js"
end
cookbook_file "/usr/share/grafana/public/app/getdash/getdash.conf.js" do
	source "getdash.conf.js"
end
cookbook_file "/usr/share/grafana/public/app/getdash/getdash.js" do
	source "getdash.js"
end

link "/usr/share/grafana/public/dashboards/getdash.js" do
	to "/usr/share/grafana/public/app/getdash/getdash.js"
end

service "grafana-server" do
	action [ :start, :enable ]
end




message_statsd = {
	"name" => 'local_influxdb_statsd',
	"type" => 'influxdb',
	"access" => 'proxy',
	"url" => "http://127.0.0.1:#{node[:raven_statsd][:influxdb][:http_port]}",
	"password" => node[:raven_statsd][:influxdb][:password],
	"user" => node[:raven_statsd][:influxdb][:user],
	"database" => node[:raven_statsd][:influxdb][:graphite_db],
	"isDefault" => true
}.to_json

message_collectd = {
	"name" => 'local_influxdb_collectd',
	"type" => 'influxdb',
	"access" => 'proxy',
	"url" => "http://127.0.0.1:#{node[:raven_statsd][:influxdb][:http_port]}",
	"password" => node[:raven_statsd][:influxdb][:password],
	"user" => node[:raven_statsd][:influxdb][:user],
	"database" => node[:raven_statsd][:influxdb][:collectd_db],
	"isDefault" => false

}.to_json

bash 'create_influxdb_data_source_statsd' do
	not_if "curl -s http://#{node[:raven_statsd][:grafana][:admin][:username]}:#{node[:raven_statsd][:grafana][:admin][:password]}@127.0.0.1:#{node[:raven_statsd][:grafana][:http_port]}/api/datasources |grep -q #{node[:raven_statsd][:influxdb][:graphite_db]}"
	code <<-EOH
	sleep 10
	curl -H 'Content-Type: application/json' -X POST -d '#{message_statsd}' -s http://#{node[:raven_statsd][:grafana][:admin][:username]}:#{node[:raven_statsd][:grafana][:admin][:password]}@127.0.0.1:#{node[:raven_statsd][:grafana][:http_port]}/api/datasources 2>&1 >>/tmp/tmp
	EOH
end

bash 'create_influxdb_data_source_collectd' do
	not_if "curl -s http://#{node[:raven_statsd][:grafana][:admin][:username]}:#{node[:raven_statsd][:grafana][:admin][:password]}@127.0.0.1:#{node[:raven_statsd][:grafana][:http_port]}/api/datasources |grep -q #{node[:raven_statsd][:influxdb][:collectd_db]}"
	code <<-EOH
	sleep 10
	curl -H 'Content-Type: application/json' -X POST -d '#{message_collectd}' -s http://#{node[:raven_statsd][:grafana][:admin][:username]}:#{node[:raven_statsd][:grafana][:admin][:password]}@127.0.0.1:#{node[:raven_statsd][:grafana][:http_port]}/api/datasources 2>&1 >>/tmp/tmp
	EOH
end
