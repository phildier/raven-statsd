remote_file "/tmp/influxdb_latest.rpm" do
	source "https://s3.amazonaws.com/influxdb/influxdb-0.8.8-1.x86_64.rpm"
end

rpm_package "influxdb" do
	source "/tmp/influxdb_latest.rpm"
end

db_dir = "#{node[:raven_statsd][:influxdb][:storage_dir]}/db"
wal_dir = "#{node[:raven_statsd][:influxdb][:storage_dir]}/wal"
raft_dir = "#{node[:raven_statsd][:influxdb][:storage_dir]}/raft"
log_dir = "#{node[:raven_statsd][:influxdb][:storage_dir]}/log"

[
	db_dir,
	wal_dir,
	raft_dir,
	log_dir,
].each do |d|
	directory d do
		recursive true
		user "influxdb"
		group "influxdb"
	end
end

template "/opt/influxdb/shared/config.toml" do
	source "config.toml.erb"
	variables ({
			:log_file => "#{log_dir}/influxdb.log",
			:storage_dir => db_dir,
			:raft_dir => raft_dir,
			:writeaheadlog_dir => wal_dir
			})
	notifies :restart, "service[influxdb]", :immediately
end

service "influxdb" do
	action [:start, :enable]
end

if_dbs = ["stats","grafana"]
if_dbs.each do |db|
	influxdb_database db
end

influxdb_user node[:raven_statsd][:influxdb][:user] do
	password node[:raven_statsd][:influxdb][:password]
	dbadmin if_dbs
end
