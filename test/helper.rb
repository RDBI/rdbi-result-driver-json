require 'rubygems'
gem 'test-unit'
gem 'rdbi'
gem 'rdbi-driver-mock'
require 'test/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rdbi'
require 'rdbi/driver/mock'
require 'rdbi/result/driver/json'

class Test::Unit::TestCase
end
