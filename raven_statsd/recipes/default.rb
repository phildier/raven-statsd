
directory node[:raven_statsd][:tmp_dir]

package "httpd"

file "/etc/httpd/conf.d/welcome.conf" do
	action :delete
end

service "httpd" do
	action [:start, :enable]
end

