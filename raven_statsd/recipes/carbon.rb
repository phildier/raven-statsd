
storage_dir = node[:raven_statsd][:storage_dir]

directory storage_dir do
	recursive true
end

template "/etc/carbon/carbon.conf" do
	source "carbon.conf.erb"
	variables ({
			:storage_dir => storage_dir,
			:local_storage_dir => "#{storage_dir}/whisper",
			:whitelists_dir => "#{storage_dir}/lists",
			:conf_dir => "/etc/carbon",
			:log_dir => "/var/log/carbon",
			:pid_dir => "/var/run"
			})
	notifies :reload, "service[carbon-cache]", :delayed
end

file "/etc/carbon/storage-schemas.conf" do
	content <<-EOH
[stats]
priority = 110
pattern = ^stats\..*
retentions = 10:2160,60:10080,600:262974
	EOH
	notifies :reload, "service[carbon-cache]", :delayed
end

service "carbon-cache" do
	action [:start, :enable]
end
