name			 'raven_statsd'
maintainer	   'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license		  'All rights reserved'
description	  'Installs/Configures raven_statsd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version		  '0.1.0'

depends "influxdb"

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

attribute "raven_statsd/influxdb/storage_dir",
	:display_name => "InfluxDB Storage Directory",
	:description => "InfluxDB Storage Directory",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::influxdb","raven_statsd::statsd_server"]
