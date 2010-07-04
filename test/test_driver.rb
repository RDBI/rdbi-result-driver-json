require 'helper'

class TestDriver < Test::Unit::TestCase
  def setup
    @dbh = mock_connect
  end

  def teardown
    @dbh.disconnect
  end

  def test_01_results_working
    sth = mock_statement_with_results(@dbh, [[1,2,3]])

    json = sth.execute.fetch(:all, :JSON)
    assert_equal('[[1,2,3]]', json)

    json = sth.execute.as(:JSON).fetch(:all)
    assert_equal('[[1,2,3]]', json)

    sth.finish
  end

  def test_02_as_object_results
    # XXX extra fields here are due to the default fields the mock yields.
    sth = mock_statement_with_results(@dbh, [[1,2,3]])

    json = sth.execute.fetch(:all, :JSON, :as_object => true)
    assert_equal("[{\"5\":null,\"0\":1,\"6\":null,\"1\":2,\"7\":null,\"2\":3,\"8\":null,\"3\":null,\"9\":null,\"4\":null}]", json)
    
    json = sth.execute.as(:JSON, :as_object => true).fetch(:all)
    assert_equal("[{\"5\":null,\"0\":1,\"6\":null,\"1\":2,\"7\":null,\"2\":3,\"8\":null,\"3\":null,\"9\":null,\"4\":null}]", json)

    sth.finish
  end
end
