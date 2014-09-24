default[:raven_statsd][:tmp_dir] = "/tmp/attachments"
default[:raven_statsd][:attachment_url] =  "http://raven-opensource.s3.amazonaws.com"

default[:raven_statsd][:storage_dir] =  "/opt/graphite/storage"
default[:raven_statsd][:storage_device] =  ""

default[:raven_statsd][:supervisord][:port] = 9110
default[:raven_statsd][:supervisord][:username] = "superuser"
default[:raven_statsd][:supervisord][:password] = (0...50).map { ('a'..'z').to_a[rand(26)] }.join

default[:raven_statsd][:graphite][:fqdn] = "graphite.site"

default[:raven_statsd][:grafana][:fqdn] = "grafana.site"
default[:raven_statsd][:grafana][:install_dir] = "/usr/share/grafana"
