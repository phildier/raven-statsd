
include_recipe "raven_statsd::default"

package "fontconfig"

grafana_rpm = "#{node[:raven_statsd][:tmp_dir]}/grafana-2.0.2-1.x86_64.rpm"
remote_file grafana_rpm do
	source "https://grafanarel.s3.amazonaws.com/builds/grafana-2.0.2-1.x86_64.rpm"
end

rpm_package grafana_rpm

# temporary, until this in a release https://github.com/grafana/grafana/pull/2205
cookbook_file "/etc/init.d/grafana-server" do
	mode 0755
end

service "grafana-server" do
	action [ :start, :enable ]
end

# redirect 80 to 3000
iptables_rule "grafana_80" do
	action :enable
end

service "iptables" do
	action [ :start, :enable ]
end
