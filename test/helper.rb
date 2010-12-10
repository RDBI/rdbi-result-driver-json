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
  def mock_connect
    RDBI.connect(:Mock)
  end

  def mock_statement_with_results(dbh, results)
    sth = dbh.prepare("some statement")
    sth.result = results
    return sth
  end
end
