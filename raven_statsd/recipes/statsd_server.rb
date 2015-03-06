# stats database and dashboard storage for grafana
include_recipe "raven_statsd::influxdb"

# replacement for statsd daemon
include_recipe "raven_statsd::bucky"

# stats dashboard
include_recipe "raven_statsd::grafana"
