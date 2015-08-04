
include_recipe "raven_statsd::default"

package "fontconfig"

grafana_rpm = "#{node[:raven_statsd][:tmp_dir]}/grafana-2.1.0-1.x86_64.rpm"
remote_file grafana_rpm do
	source "https://grafanarel.s3.amazonaws.com/builds/grafana-2.1.0-1.x86_64.rpm"
end

rpm_package grafana_rpm

# temporary, until this in a release https://github.com/grafana/grafana/pull/2205
cookbook_file "/etc/init.d/grafana-server" do
	mode 0755
end

directory node[:raven_statsd][:grafana][:data_dir] do
	user "grafana"
	group "grafana"
end

template "/etc/grafana/grafana.ini" do
	source "grafana.ini.erb"
	variables ({
			:google_client_id => node[:raven_statsd][:google][:client_id],
			:google_client_secret => node[:raven_statsd][:google][:client_secret],
			:google_domain => node[:raven_statsd][:google][:domain],
			:admin_username => node[:raven_statsd][:admin][:username],
			:admin_password => node[:raven_statsd][:admin][:password],
			:root_url => node[:raven_statsd][:server][:root_url],
			:data_dir => node[:raven_statsd][:grafana][:data_dir]
			})
	notifies :restart, "service[grafana-server]", :delayed
end

service "grafana-server" do
	action [ :start, :enable ]
end
