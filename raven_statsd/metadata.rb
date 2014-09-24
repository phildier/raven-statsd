name			 'raven_statsd'
maintainer	   'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license		  'All rights reserved'
description	  'Installs/Configures raven_statsd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version		  '0.1.0'

recipe "raven_statsd::default",			"install/configure dependencies"
recipe "raven_statsd::epel",			"sets up epel repository"
recipe "raven_statsd::mount",			"mounts storage volume"
recipe "raven_statsd::graphite",		"install/configure graphite and dependencies"
recipe "raven_statsd::carbon",			"install/configure carbon. included by graphite recipe"
recipe "raven_statsd::statsd",			"install/configure statsd and dependencies"
recipe "raven_statsd::supervisor",		"install/configure supervisor and dependencies"
recipe "raven_statsd::grafana",			"install/configure grafana"
recipe "raven_statsd::elasticsearch",	"install/configure elasticsearch for grafana"

attribute "raven_statsd/storage_dir",
	:display_name => "Graphite Storage Directory",
	:description => "Path to graphite stats storage",
	:required => "recommended",
	:default => "/var/lib/graphite",
	:type => "string",
	:recipes => ["raven_statsd::mount"]

attribute "raven_statsd/storage_device",
	:display_name => "Graphite Storage Device",
	:description => "Device to mount to storage directory",
	:required => "optional",
	:type => "string",
	:recipes => ["raven_statsd::mount"]

attribute "raven_statsd/graphite/fqdn",
	:display_name => "Graphite FQDN",
	:description => "Graphite FQDN",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::grafana","raven_statsd::graphite"]

attribute "raven_statsd/grafana/fqdn",
	:display_name => "Grafana FQDN",
	:description => "Grafana FQDN",
	:required => "required",
	:type => "string",
	:recipes => ["raven_statsd::grafana","raven_statsd::graphite"]
