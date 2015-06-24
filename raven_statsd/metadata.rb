name			 'raven_statsd'
maintainer	   'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license		  'All rights reserved'
description	  'Installs/Configures raven_statsd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version		  '0.2.0'

depends "influxdb"
depends "iptables"

recipe "raven_statsd::default",			"install/configure dependencies"
recipe "raven_statsd::epel",			"sets up epel repository"
recipe "raven_statsd::bucky",			"install/configure bucky statsd daemon"
recipe "raven_statsd::supervisor",		"install/configure supervisor and dependencies"
recipe "raven_statsd::grafana",			"install/configure grafana"
recipe "raven_statsd::influxdb",		"install/configure influxdb"
recipe "raven_statsd::statsd_server",	"installs and configures all dependencies for a stats server"

attribute "raven_statsd/grafana/fqdn",
	:display_name => "Grafana FQDN",
	:description => "Grafana FQDN",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::grafana","raven_statsd::statsd_server"]

attribute "raven_statsd/influxdb/host",
	:display_name => "InfluxDB Host:Port",
	:description => "InfluxDB Host:Port",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::grafana","raven_statsd::statsd_server"]

attribute "raven_statsd/influxdb/password",
	:display_name => "InfluxDB password",
	:description => "InfluxDB password",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::grafana","raven_statsd::statsd_server"]

attribute "raven_statsd/influxdb/storage_dir",
	:display_name => "InfluxDB Storage Directory",
	:description => "InfluxDB Storage Directory",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::influxdb","raven_statsd::statsd_server"]

attribute "raven_statsd/admin/username",
	:display_name => "Grafana Admin Username",
	:description => "Grafana Admin Username",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::statsd_server","raven_statsd::grafana"]

attribute "raven_statsd/admin/password",
	:display_name => "Grafana Admin Password",
	:description => "Grafana Admin Password",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::statsd_server","raven_statsd::grafana"]

attribute "raven_statsd/google/client_id",
	:display_name => "Google API client id",
	:description => "Google API client id",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::statsd_server","raven_statsd::grafana"]

attribute "raven_statsd/google/client_secret",
	:display_name => "Google API client secret",
	:description => "Google API client secret",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::statsd_server","raven_statsd::grafana"]

attribute "raven_statsd/google/domain",
	:display_name => "Google API allowed domain",
	:description => "Google API allowed domain",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::statsd_server","raven_statsd::grafana"]
