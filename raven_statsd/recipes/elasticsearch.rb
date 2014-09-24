
package "java-1.7.0-openjdk"

tmp_file = "#{node[:raven_statsd][:tmp_dir]}/elasticsearch-1.3.2.noarch.rpm"

remote_file tmp_file do
	source "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.noarch.rpm"
end

rpm_package "elasticsearch" do
	source tmp_file
end

link "/usr/bin/elasticsearch" do
	to "/usr/share/elasticsearch/bin/elasticsearch"
end

service "elasticsearch" do
	action [:enable, :start]
end
