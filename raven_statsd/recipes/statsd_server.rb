# stats database and dashboard storage for grafana
include_recipe "raven_statsd::influxdb"

# stats dashboard
include_recipe "raven_statsd::grafana"
