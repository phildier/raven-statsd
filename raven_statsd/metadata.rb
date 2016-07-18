name							'raven_statsd'
maintainer				'Raven Tools'
maintainer_email 	'devops@raventools.com'
license						'All rights reserved'
description				'Installs/Configures raven_statsd'
long_description 	IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version						'0.3.0'


recipe "raven_statsd::default",	"install/configure dependencies"
recipe "raven_statsd::grafana",	"install/configure grafana"
recipe "raven_statsd::influxdb",	"install/configure influxdb"
recipe "raven_statsd::statsd_server",	"installs and configures all dependencies for a stats server"

attribute "raven_statsd/server/fqdn",
	:display_name => "Grafana host name",
	:description => "Grafana host name",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::grafana","raven_statsd::statsd_server"]

attribute "raven_statsd/server/public_fqdn",
	:display_name => "Grafana public url",
	:description => "Grafana public url",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::grafana","raven_statsd::statsd_server"]

attribute "raven_statsd/grafana/data_dir",
	:display_name => "Grafana Storage Directory",
	:description => "Grafana Storage Directory",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::statsd_server"]

attribute "raven_statsd/grafana/admin/username",
	:display_name => "Grafana Admin Username",
	:description => "Grafana Admin Username",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::statsd_server","raven_statsd::grafana"]

attribute "raven_statsd/grafana/admin/password",
	:display_name => "Grafana Admin Password",
	:description => "Grafana Admin Password",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::statsd_server","raven_statsd::grafana"]

attribute "raven_statsd/grafana/google/client_id",
	:display_name => "Google API client id",
	:description => "Google API client id",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::statsd_server","raven_statsd::grafana"]

attribute "raven_statsd/grafana/google/client_secret",
	:display_name => "Google API client secret",
	:description => "Google API client secret",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::statsd_server","raven_statsd::grafana"]

attribute "raven_statsd/grafana/google/domain",
	:display_name => "Google API allowed domain",
	:description => "Google API allowed domain",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::statsd_server","raven_statsd::grafana"]



attribute "raven_statsd/influxdb/user",
	:display_name => "InfluxDB user name",
	:description => "InfluxDB user name",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::influxdb","raven_statsd::grafana","raven_statsd::statsd_server"]

attribute "raven_statsd/influxdb/password",
	:display_name => "InfluxDB user password",
	:description => "InfluxDB user password",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::influxdb","raven_statsd::grafana","raven_statsd::statsd_server"]

attribute "raven_statsd/influxdb/adminuser",
	:display_name => "InfluxDB admin user name",
	:description => "InfluxDB admin user name",
	:required => "required",
	:type => "string",
	:default => "admin",
	:recipes => ["raven_statsd::influxdb","raven_statsd::statsd_server"]

attribute "raven_statsd/influxdb/adminpass",
	:display_name => "InfluxDB admin password",
	:description => "InfluxDB admin password",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::influxdb","raven_statsd::statsd_server"]

attribute "raven_statsd/influxdb/http_port",
	:display_name => "InfluxDB http port",
	:description => "InfluxDB http port",
	:required => "required",
	:type => "string",
	:default => "8000",
	:recipes => ["raven_statsd::influxdb","raven_statsd::grafana","raven_statsd::statsd_server"]

attribute "raven_statsd/influxdb/collectd_port",
	:display_name => "InfluxDB collectd port",
	:description => "InfluxDB collectd port",
	:required => "required",
	:type => "string",
	:default => "8125",
	:recipes => ["raven_statsd::influxdb","raven_statsd::statsd_server"]

attribute "raven_statsd/influxdb/collectd_db",
	:display_name => "InfluxDB collectd db",
	:description => "InfluxDB collectd db",
	:required => "required",
	:type => "string",
	:default => "8125",
	:recipes => ["raven_statsd::influxdb","raven_statsd::grafana","raven_statsd::statsd_server"]


attribute "raven_statsd/influxdb/base_dir",
	:display_name => "InfluxDB Storage Directory",
	:description => "InfluxDB Storage Directory",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::influxdb","raven_statsd::statsd_server"]

attribute "raven_statsd/influxdb/dbs",
	:display_name => "InfluxDB databases to create",
	:description => "InfluxDB databases to create",
	:required => "required",
	:type => "array",
	:recipes => ["raven_statsd::influxdb","raven_statsd::statsd_server"]
