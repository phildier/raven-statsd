
include_recipe "raven_statsd::default"

grafana_tarball = "#{node[:raven_statsd][:tmp_dir]}/grafana.tar.gz"
remote_file grafana_tarball do
	source "http://grafanarel.s3.amazonaws.com/grafana-1.8.0.tar.gz"
end

directory node[:raven_statsd][:grafana][:install_dir] do
	recursive true
end

execute "unpack-grafana-tarball" do
	command "tar xf #{grafana_tarball} -C #{node[:raven_statsd][:grafana][:install_dir]}"
end

template "/etc/httpd/conf.d/grafana.conf" do
	source "vhost.conf.erb"
	variables ({
			:server_name => "grafana",
			:document_root => node[:raven_statsd][:grafana][:install_dir],
			:fqdn =>  node[:raven_statsd][:grafana][:fqdn]
			})
	notifies :reload, "service[httpd]", :delayed
end

template "#{node[:raven_statsd][:grafana][:install_dir]}/config.js" do
	source "grafana-config.js.erb"
	variables ({
			:graphite_host => node[:raven_statsd][:graphite][:fqdn],
			:grafana_host => node[:raven_statsd][:grafana][:fqdn],
			:password => "confirm",
			:title_prefix => "Raven Graphs"
			})
end
