
gem_package "statsd-ruby"

file "/root/teststats.rb" do
	content <<-EOH
require 'rubygems'
require 'statsd-ruby'

s = Statsd.new 'localhost', 8125

(1..100).each {
	s.increment('app.test.one')
}
	EOH
end
