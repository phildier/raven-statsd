
if !node[:raven_statsd][:storage_device].nil? then
	mount node[:raven_statsd][:storage_dir] do
   		device node[:raven_statsd][:storage_device]
		action :mount
	end
end
