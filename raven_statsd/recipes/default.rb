
include_recipe "iptables"

directory node[:raven_statsd][:tmp_dir]
