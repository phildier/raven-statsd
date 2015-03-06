default[:raven_statsd][:tmp_dir] = "/tmp/attachments"
default[:raven_statsd][:attachment_url] =  "http://raven-opensource.s3.amazonaws.com"

default[:raven_statsd][:supervisord][:port] = 9110
default[:raven_statsd][:supervisord][:username] = "superuser"
default[:raven_statsd][:supervisord][:password] = (0...50).map { ('a'..'z').to_a[rand(26)] }.join

default[:raven_statsd][:grafana][:fqdn] = "grafana.site"
default[:raven_statsd][:grafana][:install_dir] = "/usr/share/grafana"

default[:raven_statsd][:influxdb][:host] = "grafana.site:8086"
default[:raven_statsd][:influxdb][:user] = "grafana"
default[:raven_statsd][:influxdb][:password] = "]Zg}IL0[O277!d:;"
default[:raven_statsd][:influxdb][:storage_dir] = "/var/lib/influxdb"
