
directory node[:raven_statsd][:tmp_dir]

package "httpd"

service "httpd" do
	action [:start, :enable]
end
