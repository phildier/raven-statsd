
package "python-whisper"
package "python-carbon"
package "graphite-web"
package "python-memcached"
package "python-ldap"
package "httpd"
package "memcached"

include_recipe "raven_statsd::carbon"

# configure auth database and storage paths
template "/etc/graphite-web/local_settings.py" do
	source "local_settings.py.erb"
	variables ({
			:storage_dir => node[:raven_statsd][:storage_dir],
			:secret_key => node[:raven_statsd][:secret_key],
			})
	notifies :restart, "service[httpd]", :delayed
end

# tweak graphite vhost
template "/etc/httpd/conf.d/graphite-web.conf" do
	source "graphite-vhost.conf.erb"
	variables ({
			:server_name => node[:raven_statsd][:graphite][:fqdn],
			:document_root => "/usr/share/graphite/webapp",
			:grafana_host => node[:raven_statsd][:grafana][:fqdn]
			})
end

service "memcached" do
	action [:start, :enable]
end

service "httpd" do
	action [:start, :enable]
end
