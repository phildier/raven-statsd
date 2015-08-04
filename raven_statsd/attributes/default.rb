default[:raven_statsd][:tmp_dir] = "/tmp/attachments"
default[:raven_statsd][:attachment_url] =  "http://raven-opensource.s3.amazonaws.com"

default[:raven_statsd][:supervisord][:port] = 9110
default[:raven_statsd][:supervisord][:username] = "superuser"
default[:raven_statsd][:supervisord][:password] = (0...50).map { ('a'..'z').to_a[rand(26)] }.join

default[:raven_statsd][:grafana][:fqdn] = "grafana.site"
default[:raven_statsd][:grafana][:install_dir] = "/usr/share/grafana"
default[:raven_statsd][:grafana][:public_dir] = "/usr/share/grafana/public"
default[:raven_statsd][:grafana][:data_dir] = "/var/lib/grafana"

default[:raven_statsd][:influxdb][:host] = "grafana.site:8086"
default[:raven_statsd][:influxdb][:user] = "grafana"
default[:raven_statsd][:influxdb][:password] = "grafana"
default[:raven_statsd][:influxdb][:storage_dir] = "/var/lib/influxdb"

default[:raven_statsd][:server][:root_url] = 'http://localhost:8099/'
default[:raven_statsd][:google][:client_id] = nil
default[:raven_statsd][:google][:client_secret] = nil
default[:raven_statsd][:google][:domain] = "example.com"
default[:raven_statsd][:admin][:username] = "admin"
default[:raven_statsd][:admin][:password] = "admin"

