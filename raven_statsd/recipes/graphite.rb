
package "python-whisper"
package "python-carbon"
package "graphite-web"
package "python-memcached"
package "python-ldap"
package "httpd"
package "memcached"

include_recipe "raven_statsd::carbon"

# configure auth database
file "/etc/graphite-web/local_settings.py" do
	content <<-EOH
LOG_DIR = "#{node[:raven_statsd][:storage_dir]}"
INDEX_FILE = "#{node[:raven_statsd][:storage_dir]}/index"
SECRET_KEY = "#{node[:raven_statsd][:secret_key]}"
WHISPER_DIR = "#{storage_dir}/whisper/"
DATABASES = {
    'default': {
        'NAME': '#{node[:raven_statsd][:storage_dir]}/graphite.db',
        'ENGINE': 'django.db.backends.sqlite3',
        'USER': '',
        'PASSWORD': '',
        'HOST': '',
        'PORT': ''
    }
}
	EOH
	notifies :restart, "service[httpd]", :delayed
end

service "carbon-cache" do
	action [:start, :enable]
end

service "memcached" do
	action [:start, :enable]
end

service "httpd" do
	action [:start, :enable]
end
