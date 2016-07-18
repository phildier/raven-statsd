

default[:raven_statsd][:grafana][:fqdn] = "grafana.site"
default[:raven_statsd][:grafana][:public_fqdn] = "http://grafana.site:8099"
default[:raven_statsd][:grafana][:data_dir] = "/var/lib/grafana"
default[:raven_statsd][:grafana][:http_port] = "8000"
default[:raven_statsd][:grafana][:admin][:username] = "admin"
default[:raven_statsd][:grafana][:admin][:password] = "admin"
default[:raven_statsd][:grafana][:google][:client_id] = "your_id"
default[:raven_statsd][:grafana][:google][:client_secret] = "your_sec"
default[:raven_statsd][:grafana][:google][:domain] = "your_domain"


default[:raven_statsd][:influxdb][:user] = "grafana"
default[:raven_statsd][:influxdb][:password] = "grafana"
default[:raven_statsd][:influxdb][:adminuser] = "admin"
default[:raven_statsd][:influxdb][:adminpass] = "admin"
default[:raven_statsd][:influxdb][:dbs] = ["collectd","statsd","grafana"]
default[:raven_statsd][:influxdb][:base_dir] = "/var/lib/influxdb"
default[:raven_statsd][:influxdb][:http_port] = "8086"
default[:raven_statsd][:influxdb][:enable_collectd] = "true"
default[:raven_statsd][:influxdb][:collectd_port] = "25826"
default[:raven_statsd][:influxdb][:collectd_db] = "collectd"
default[:raven_statsd][:influxdb][:enable_graphite] = "true"
default[:raven_statsd][:influxdb][:graphite_port] = "2003"
default[:raven_statsd][:influxdb][:graphite_db] = "statsd"
default[:raven_statsd][:bucky][:enable] = "true"
