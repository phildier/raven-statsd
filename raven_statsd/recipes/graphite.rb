
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
SECRET_KEY = "#{node[:raven_statsd][:secret_key]}"
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
